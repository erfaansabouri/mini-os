
;OS boot_loader

[bits 16]
[org 0x7c00]

boot:
	
	mov ah, 0x02		; BIOS read sector function
	mov al, 0x08		; read three sector
	mov dh,	0x00		; Head to read
	mov dl,	0x00		; Drive to read
	mov ch,	0x00		; Track to read
	mov cl,	0x02		; Sector to read
	
	mov bx, 0x0000
	mov es, bx
	mov bx, 0x7E00
	
jmp_kernel:
	int 13h		
	jc jmp_kernel		; Carry Flag Set On Error, Clear If No Error
	jmp lose_cursor
	
	
times 510 - ($-$$) db 0
dw 0xaa55

gdtr :
   dw gdt_end-gdt-1      ; Length of the gdt
   dd gdt		       ; physical address of gdt
gdt
nullsel equ $-gdt           ; $->current location,so nullsel = 0h
gdt0 		       ; Null descriptor,as per convention gdt0 is 0
   dd 0		       ; Each gdt entry is 8 bytes, so at 08h it is CS
   dd 0                      ; In all the segment descriptor is 64 bits
codesel equ $-gdt	       ; This is 8h,ie 2nd descriptor in gdt
code_gdt		       ; Code descriptor 4Gb flat segment at 0000:0000h
   dw 0xffff	       ; Limit 4Gb  bits 0-15 of segment descriptor
   dw 0x0000	       ; Base 0h bits 16-31 of segment descriptor (sd)
   db 0x00                  ; Base addr of seg 16-23 of 32bit addr,32-39 of sd	
   db 0x9a	       ; P,DPL(2),S,TYPE(3),A->Present bit 1,Descriptor				       ; privilege level 0-3,Segment descriptor 1 ie code	    		                  ; or data seg descriptor,Type of seg,Accessed bit
   db 0xcf	       ; Upper 4 bits G,D,0,AVL ->1 segment len is page		                                     ; granular, 1 default operation size is 32bit seg		                              ; AVL : Available field for user or OS
                              ; Lower nibble bits 16-19 of segment limit
   db 0x00	       ; Base addr of seg 24-31 of 32bit addr,56-63 of sd
datasel equ $-gdt	       ; ie 10h, beginning of next 8 bytes for data sd
data_gdt		       ; Data descriptor 4Gb flat seg at 0000:0000h
   dw 0xffff	       ; Limit 4Gb
   dw 0x0000	       ; Base 0000:0000h
   db 0x00	       ; Descriptor format same as above
   db 0x92
   db 0xcf
   db 0x00
videosel equ $-gdt	       ; ie 18h,next gdt entry
   dw 3999	       ; Limit 80*25*2-1
   dw 0x8000	       ; Base 0xb8000
   db 0x0b
   db 0x92	       ; present,ring 0,data,expand-up,writable
   db 0x00	       ; byte granularity 16 bit
   db 0x00
gdt_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

;;;;;
lose_cursor:
	mov bh , 0			; lose cursor
	mov dh, -1
	mov dl, -1
	mov ah, 0x02
	int 10h
;;;;;

go_pm:
	cli		    	; Clear or disable interrupts
	lgdt[gdtr]	    ; Load GDT	 
	mov eax,cr0	    ; The lsb of cr0 is the protected mode bit
	or al,0x01	    ; Set protected mode bit
	mov cr0,eax	    ; Mov modified word to the control register
	jmp codesel:start   

bits 32	
start:
	mov eax,datasel   
	mov ds,eax	       ; Initialise ds & es to data segment
	mov es,eax
	mov eax,videosel	       ; Initialise gs to video memory
	mov gs, eax
	mov ebp, 0x90000
	mov esp, ebp
	call kernel_start
	jmp $


%include "kernel_test.asm"
;%include "kernel.asm"
;%include "cal.asm"
;;;;;;;;;;;;;;;;;;; KERNEL

