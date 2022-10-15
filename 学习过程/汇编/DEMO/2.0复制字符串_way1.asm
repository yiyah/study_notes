; 程序功能：把 data 段中的字符串复制一份

assume cs:code,ds:data

data segment

        db      'welcome to masm!'
        db      '................'

data ends

code segment


start:      mov ax,data
            mov ds,ax
            mov bx,0

            mov si,0
            mov di,16
            mov cx,8

cpystring:  mov ax,ds:[si]
            mov ds:[di],ax
            add si,2
            add di,2
            loop cpystring

            mov ax,4c00H
            int 21H


code ends

end start
