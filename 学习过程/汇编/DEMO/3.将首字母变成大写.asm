assume cs:code,ds:data,ss:stack

data segment
                ;0123456789ABCDEF
        db      '1. file         '
        db      '2. edit         '
        db      '3. search       '
        db      '4. view         '
        db      '5. options      '
        db      '6. help         '
data ends

stack segment stack
        dw      0,0,0,0,0,0,0,0
stack ends

code segment

start:          mov ax,stack
                mov ss,ax

                mov ax,data
                mov ds,ax
                mov bx,0
                mov si,3
                
                mov cx,6
                
next:           mov al,ds:[bx+si]
                and al,11011111B
                mov ds:[bx+si],al
                add bx,10H
                loop next
                
                mov ax,4c00h
                int 21H

code ends

end start
