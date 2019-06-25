bits 32
integer db '-12345',0
string db '      ',0
kernel_start:   
call clear_page


mov bx,0 ; inital cursor



print_first_line_margin:
	cmp bx,160
	je end_print_first_line_margin
	mov word [gs:bx] , 0x713D ; hashtag
	add bx,2
jmp print_first_line_margin

end_print_first_line_margin:


mov bx, 160 ; first of second line
left_right_margin:
	cmp bx,3800
	jg end_left_right_margin
	mov word [gs:bx] , 0x7123
	add bx,158
	mov word [gs:bx] , 0x7123
	add bx,2
jmp left_right_margin

end_left_right_margin:

;footer
footer_margin:
	cmp bx,4000
	je end_footer_margin
	mov word [gs:bx] , 0x713D
	add bx,2
jmp footer_margin

end_footer_margin:


;Write Loading
; eOS Loading . . .
mov bx,3902 ; middle
mov word [gs:bx] , 0xF065 ; eOS

mov bx,3904
mov word [gs:bx] , 0xF04F

mov bx,3906
mov word [gs:bx] , 0xF053

mov bx,3908
mov word [gs:bx] , 0xF020 ; space

mov bx,3910
mov word [gs:bx] , 0xF041 ; A

mov bx,3912
mov word [gs:bx] , 0xF04C ; L

mov bx,3914
mov word [gs:bx] , 0xF049 ; I

mov bx,3916
mov word [gs:bx] , 0xF056 ; V

mov bx,3918
mov word [gs:bx] , 0xF045 ; E

mov bx,3920
mov word [gs:bx] , 0xF020 ; space

mov bx,3922
mov word [gs:bx] , 0xF02E ; .

mov bx,3924
mov word [gs:bx] , 0xF020 ; space


mov bx,3926
mov word [gs:bx] , 0xF02E ; .


mov bx,3928
mov word [gs:bx] , 0xF020 ; space

mov bx,3930
mov word [gs:bx] , 0xF02E ; .


mov bx,3932
mov word [gs:bx] , 0xF020 ; space

mov bx,3934
mov word [gs:bx] , 0xF02E ; .

;jmp $


mov bx, 162

input:
	in al, 0x60 ; open port 60

	; switch case on keys

	cmp al,0x0B ; if key = '0'
		je print_0

	cmp al,0x02 ; if key='1'
		je print_1 
		
	cmp al,0x03 ; if key='2'
		je print_2
		
	cmp al,0x04 ; if key='3'
		je print_3 
		
	cmp al,0x05 ; if key='4'
		je print_4 
		
	cmp al,0x06 ; if key='5'
		je print_5 	
	
	cmp al,0x07 ; if key='6'
		je print_6
	
	cmp al,0x08 ; if key='7'
		je print_7
		
	cmp al,0x09 ; if key='8'
		je print_8
		
	cmp al,0x0A ; if key='9'
		je print_9
		
	cmp al,0x1C ; if key=enter
		je go_to_next_line
		
	cmp al,0x0E ; if key=backspace
		je remove_char
		
	cmp al,0x39 ; if key=space
		je print_space
		
	cmp al,0x1E ; if key='a'
		je print_a
		
	cmp al,0x30 ; b 
		je print_b
		
	cmp al,0x2E ; c 
		je print_c
		
	cmp al,0x20 ; d
		je print_d
		
	cmp al,0x12 ; e 
		je print_e
		
	cmp al,0x21 ; f 
		je print_f
		
	cmp al,0x22 ; g 
		je print_g
		
	cmp al,0x23 ; h
		je print_h
		
	cmp al,0x17 ; i 
		je print_i

	cmp al,0x24 ; j 
		je print_j
		
	cmp al,0x25 ; k 
		je print_k
		
	cmp al,0x26 ; l
		je print_l

	cmp al,0x32 ; m
		je print_m
		
	cmp al,0x31 ; n
		je print_n
		
	cmp al,0x18 ; o 
		je print_o
		
	cmp al,0x19
		je print_p
		
	cmp al,0x10 ; q
		je print_q
		
	cmp al,0x13 ; r 
		je print_r
		
	cmp al,0x1F ; s 
		je print_s
		
	cmp al,0x14 ; t 
		je print_t
		
	cmp al,0x16
		je print_u
		
	cmp al,0x2F
		je print_v
		
	cmp al,0x11
		je print_w
		
	cmp al,0x2D
		je print_x
		
	cmp al,0x15
		je print_y
		
	cmp al,0x2C
		je print_z

	jne input

	print_0:
		mov word [gs:bx], 0x3130
		jmp forward_cursor

	print_1:
		mov word [gs:bx], 0x3131
		jmp forward_cursor


	print_2:
		mov word [gs:bx], 0x3132
		jmp forward_cursor
		
	print_3:
		mov word [gs:bx], 0x3133
		jmp forward_cursor

	print_4:
		mov word [gs:bx], 0x3134
		jmp forward_cursor

	print_5:
		mov word [gs:bx], 0x3135
		jmp forward_cursor
		
	print_6:
		mov word [gs:bx], 0x3136
		jmp forward_cursor

	print_7:
		mov word [gs:bx], 0x3137
		jmp forward_cursor
		
	print_8:
		mov word [gs:bx], 0x3138
		jmp forward_cursor
		
	print_9:
		mov word [gs:bx], 0x3139
		jmp forward_cursor
		
	print_a:
		mov word [gs:bx], 0x3161
		jmp forward_cursor
		
	print_b:
		mov word [gs:bx], 0x3162
		jmp forward_cursor

	print_c:
		mov word [gs:bx], 0x3163
		jmp forward_cursor
		
	print_d:
		mov word [gs:bx], 0x3164
		jmp forward_cursor

	print_e:
		mov word [gs:bx], 0x3165
		jmp forward_cursor

	print_f:
		mov word [gs:bx], 0x3166
		jmp forward_cursor
		
	print_g:
		mov word [gs:bx], 0x3167
		jmp forward_cursor
		
	print_h:
		mov word [gs:bx], 0x3168
		jmp forward_cursor
		
	print_i:
		mov word [gs:bx], 0x3169
		jmp forward_cursor
		
	print_j:
		mov word [gs:bx], 0x316A
		jmp forward_cursor
		
	print_k:
		mov word [gs:bx], 0x316B
		jmp forward_cursor
		
	print_l:
		mov word [gs:bx], 0x316C
		jmp forward_cursor
		
	print_m:
		mov word [gs:bx], 0x316D
		jmp forward_cursor
		
	print_n:
		mov word [gs:bx], 0x316E
		jmp forward_cursor
		
	print_o:
		mov word [gs:bx], 0x316F
		jmp forward_cursor
		
	print_p:
		mov word [gs:bx], 0x3170
		jmp forward_cursor
		
	print_q:
		mov word [gs:bx], 0x3171
		jmp forward_cursor
		

	print_r:
		mov word [gs:bx], 0x3172
		jmp forward_cursor
		
	print_s:
		mov word [gs:bx], 0x3173
		jmp forward_cursor
		
	print_t:
		mov word [gs:bx], 0x3174
		jmp forward_cursor
		
	print_u:
		mov word [gs:bx], 0x3175
		jmp forward_cursor
		
	print_v:
		mov word [gs:bx], 0x3176
		jmp forward_cursor
		
	print_w:
		mov word [gs:bx], 0x3177
		jmp forward_cursor
		
	print_x:
		mov word [gs:bx], 0x3178
		jmp forward_cursor
		
	print_y:
		mov word [gs:bx], 0x3179
		jmp forward_cursor
		
	print_z:
		mov word [gs:bx], 0x317A
		jmp forward_cursor
		
	print_space:
		mov word [gs:bx], 0x0020
		jmp forward_cursor	
		
		
				
	go_to_next_line:
		cmp bx,158
		jle go_to_first_line
	
		cmp bx,318
		jle go_to_second_line
		
		cmp bx,478
		jle go_to_third_line
		
		cmp bx,638
		jle go_to_fourth_line
		
		cmp bx,798
		jle go_to_fifth_line
		
		cmp bx,958
		jle go_to_sixth_line
		
		cmp bx,1118
		jle go_to_seventh_line
		
		cmp bx,1278
		jle go_to_eight_line
		
		cmp bx,1438
		jle go_to_nine_line
		
		cmp bx,1598
		jle go_to_ten_line
		
		cmp bx,1758
		jle go_to_eleven_line
		
		cmp bx,1918
		jle go_to_12_line
		
		cmp bx,2078
		jle go_to_13_line
		
		cmp bx,2238
		jle go_to_14_line
		
		cmp bx,2398
		jle go_to_15_line
		
		cmp bx,2558
		jle go_to_16_line
		
		cmp bx,2718
		jle go_to_17_line
		
		cmp bx,2878
		jle go_to_18_line
		
		cmp bx,3038
		jle go_to_19_line
		
		cmp bx,3198
		jle go_to_20_line
		
		cmp bx,3358
		jle go_to_21_line
		
		cmp bx,3518
		jle go_to_22_line
		
		cmp bx,3678
		jle go_to_23_line
		
		cmp bx,3838
		jle go_to_first_line
		
		cmp bx,4002
		jle go_to_first_line
		
		
		
		
	go_to_first_line:
		mov bx,162
		jmp buffer_state
		
	go_to_second_line:
		mov bx,322
		jmp buffer_state
		
	go_to_third_line:
		mov bx,482
		jmp buffer_state
	
	go_to_fourth_line:
		mov bx,642
		jmp buffer_state
		
	go_to_fifth_line:
		mov bx,802
		jmp buffer_state
		
	go_to_sixth_line:
		mov bx,962
		jmp buffer_state
		
	go_to_seventh_line:
		mov bx,1122
		jmp buffer_state
		
	go_to_eight_line:
		mov bx,1282
		jmp buffer_state
		
	go_to_nine_line:
		mov bx,1442
		jmp buffer_state
		
	go_to_ten_line:
		mov bx,1602
		jmp buffer_state
		
	go_to_eleven_line:
		mov bx,1762
		jmp buffer_state
		
	go_to_12_line:
		mov bx,1922
		jmp buffer_state
		
	go_to_13_line:
		mov bx,2082
		jmp buffer_state
		
	go_to_14_line
		mov bx,2242
		jmp buffer_state
		
	go_to_15_line:
		mov bx,2402
		jmp buffer_state
		
	go_to_16_line:
		mov bx,2562
		jmp buffer_state
		
		
	go_to_17_line:
		mov bx,2722
		jmp buffer_state
		
	go_to_18_line:
		mov bx,2882
		jmp buffer_state
		
	go_to_19_line:
		mov bx,3042
		jmp buffer_state
		
	go_to_20_line:
		mov bx,3202
		jmp buffer_state
		
	go_to_21_line:
		mov bx,3362
		jmp buffer_state
		
	go_to_22_line:
		mov bx,3522
		jmp buffer_state
		
	go_to_23_line:
		mov bx,3682
		jmp buffer_state
		
	go_to_24_line:
		mov bx,3840
		jmp buffer_state
		
	
	remove_char:
		sub bx,2
		mov word [gs:bx], 0x0000
		jmp buffer_state


	forward_cursor:
		add bx,2
		
		cmp bx,318 ; if margin
		je skip_margin
		
		cmp bx,478
		je skip_margin
		
		cmp bx,638
		je skip_margin
		
		cmp bx,798
		je skip_margin
		
		cmp bx,958
		je skip_margin
		
		cmp bx,1118
		je skip_margin
		
		cmp bx,1278
		je skip_margin
		
		cmp bx,1438
		je skip_margin
		
		cmp bx,1598
		je skip_margin
		
		cmp bx,1758
		je skip_margin
		
		cmp bx,1918
		je skip_margin
		
		cmp bx,2078
		je skip_margin
		
		cmp bx,2238
		je skip_margin
		
		cmp bx,2398
		je skip_margin
		
		cmp bx,2558
		je skip_margin
		
		
		cmp bx,2718
		je skip_margin
		
		cmp bx,2878
		je skip_margin
		
		cmp bx,3038
		je skip_margin
		
		cmp bx,3198
		je skip_margin
		
		cmp bx,3358
		je skip_margin
		
		cmp bx,3518
		je skip_margin
		
		cmp bx,3678
		je skip_margin
		
		
		cmp bx,3838
		je skip_margin
		
		cmp bx,3998
		je skip_margin
		
		cmp bx,4002
		je move_to_first
		
		jne buffer_state
		
		move_to_first:
			mov bx,160
		
		skip_margin:
			add bx,4
		
		
		
	buffer_state:
		in al, 0x64
		test al, 1
		jz buffer_state
		jmp input
		

jmp $


clear_page:
push bx
push gs
push ecx

mov ecx, videosel
mov gs, ecx
mov bx, 0x0000  
clear_page_while1:
cmp bx, 4000
je clear_page_end_while1
mov word [gs:bx], 0x0000
add bx, 2
jmp clear_page_while1
clear_page_end_while1:
pop ecx
pop gs
pop bx
ret
