; 程序功能：把内存的数据格式化保存，并显示格式化的内容
; 目前只显示了 年份，总收入

assume cs:code,ds:data,ss:stack

data segment
		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;以上是表示21年的21个字符串 year


		dd	16,22,382,1356,2390,8000,16000,24486,50065,9747,14041,19751
		dd	34598,59082,80353,11830,18430,27590,37530,46490,59370
		;以上是表示21年公司总收入的21个dword数据	sum

		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	11542,14430,15257,17800
                ; 公司总人数

data ends


table segment
				;0123456789ABCDEF
		db	21 dup ('year summ ne ?? ')
table ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          mov ax,stack
                mov ss,ax
                mov sp,128
                call init_reg           ; 初始化寄存器

                call input_table        ; 格式化数据
                call clear_screen
                call output_table       ; 显示格式化的数据

                mov ax,4C00H
                int 21H

; =====init_reg======
init_reg:       mov ax,data
                mov ds,ax
                ret

; =====clear_screen====
; 清屏函数
clear_screen:   mov ax,0B800H
                mov es,ax
                mov di,0
                mov cx,2000             ; 2000次即 2000*2=4000个字节
                mov ax,0700H
clearScreen:    mov es:[di],ax
                add di,2
                loop clearScreen                

; =====input_table======
; 函数功能：把数据段的数据格式化保存
input_table:    mov si,0                ; 指向年份
                ; 数据放哪里去
                mov ax,table
                mov es,ax
                mov di,0                ; 指向数据到哪去，行为单位
                ; 
                mov bx,21*4*2           ; ds:[bx] 指向公司总人数的首地址
                mov cx,21               ; 21 个数据
inputTable:     ; 保存年份，注意年份是 ASCII
                push ds:[si+0]
                pop es:[di+0]
                push ds:[si+2]
                pop es:[di+2]
                
                ; 保存总收入
                mov ax,ds:[si+21*4+0]   ; 21*4跳过年份的数据。si是指向第几个数据，每次移动移4个字节
                mov dx,ds:[si+21*4+2]   ; +0,+2 是取高低16位。
                mov es:[di+5],ax
                mov es:[di+7],dx

                ; 保存人数
                push ds:[bx]
                pop es:[di+10]

                ; 计算平均收入
                div word ptr ds:[bx]    ; 因为保存人数的时候没有用 mov ax,ds:[bx]，所以总收入的数据还在 ax,dx 中
                mov es:[di+13],ax

                ; 为下一行数据作准备
                add si,4
                add di,16
                add bx,2
                loop inputTable
                ret

; =======output_table=============
output_table:   mov ax,table
                mov ds,ax
                mov si,0

                mov ax,0B800H
                mov es,ax
                mov di,160*3+3*2

                mov cx,21
outputTable:    call show_year          ; 显示一行数据，年份
                call show_sum           ; 显示一行数据，总收入
                call show_peoplenum     ; 显示一行数据，人数
                call show_ave           ; 显示一行数据，人均收入
                add di,160              ; 换一行显示
                add si,16               ; 数据换一行取
                loop outputTable        
                ret

; ===========显示年份=============
show_year:      push ax
                push cx
                push ds
                push es
                push si
                push di

                mov cx,4
                mov ah,02H              ; 设置颜色
showYear:       mov al,ds:[si]
                mov es:[di],ax
                inc si                  ; 指向年份的下一个数字
                add di,2                ; 指向现存地址的下一个输出地址
                loop showYear

                pop di
                pop si
                pop es
                pop ds
                pop cx
                pop ax
                ret

; ===========显示总收入=============
show_sum:       push ax
                push bx
                push cx
                push dx
                push ds
                push es
                push si
                push di

                mov bx,10
                mov ax,ds:[si+5]        ; 总收入的低16位
                mov dx,ds:[si+7]        ; 总收入的高16位

                call showSum
                pop di
                pop si
                pop es
                pop ds
                pop dx
                pop cx
                pop bx
                pop ax
                ret

showSum:        ; 显示一行总收入的数据
                div bx
                add dl,30H              ; 转 ASCII
                mov dh,02H              ; 设置颜色
                mov es:[di+5*2+10*2],dx ; 显示
                mov cx,ax
                jcxz show_sumRET        ; 如果商是0就返回
                sub di,2                ; 不是的话，说明还有数字要显示
                mov dx,0
                jmp showSum             ; 继续除法

show_sumRET:    ret

; ===========显示人均收入============
show_peoplenum: 
                ret
; ===========显示人均收入============
show_ave:
                ret

code ends

end start