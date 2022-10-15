; 程序功能：把内存中的数显示到屏幕上
; 思路：ds:si 指向 “数据来自哪”，通过 16位除法不断求余得到数字的各个位后，将该数字转成 ASCII 送到显存地址


assume cs:code,ds:data,ss:stack

data segment

        dw      1234

data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          mov ax,stack
                mov ss,ax
                mov sp,128

                call init_reg

                mov si,0
                mov ax,ds:[si]          ; 参数，要显示的数字的地址
                mov di,160*10+30*2      ; 参数，要在哪里显示
                call short_div

                mov ax,4c00h
                int 21h

; ======init_reg=======
init_reg:       
                mov ax,data
                mov ds,ax
                
                mov ax,0B800H   ; 显存地址
                mov es,ax

                ret

; ======short_div=======
short_div:      mov dx,0
                mov cx,10       ; 除以10得到各个位
                div cx
                add dl,30H      ; 转 ASCII

                mov es:[di],dl
                mov byte ptr es:[di+1],00000010B        ; 设置颜色
                mov cx,ax       ; 把商放到cx中，判断是否等于0
                jcxz shortDivRet
                sub di,2
                jmp short_div

shortDivRet:    ret

code ends

end start
