; 程序功能：把 data 段中的数据全部变为大写
assume cs:code,ds:data,ss:stack

data segment
                ;0123456789ABCDEF
        db      'file            '
        db      'edit            '
        db      'sear            '
        db      'view            '
        db      'opti            '
        db      'help            '
data ends

stack segment stack
        dw      0,0,0,0,0,0,0,0
stack ends

code segment

start:          mov ax,stack
                mov ss,ax
                mov sp,16

                mov ax,data
                mov ds,ax

                mov bx,0
                mov si,0
                
                mov cx,6
nextStr:        push cx
                mov cx,4
                mov si,0
upletter:       mov al,ds:[bx+si]
                and al,11011111B
                mov ds:[bx+si],al
                inc si
                loop upletter
                
                pop cx
                add bx,16
                mov si,0
                loop nextStr

                mov ax,4c00h
                int 21H

code ends

end start
