; 程序功能：输出三行不同颜色的 字符串V1.0
; 思路：
;       step1: 先实现输出一行。
;              因为一个字符占两个字节（低字节：字符ASCII。高字节：字符属性），所以可以把这两个字节用
;              用一个16位寄存器保存，然后在写到显存地址中。                



assume cs:code,ds:data,ss:stack

data segment
                ;0123456789ABCDEF
        db      'welcome to masm!'
        db      02H,24H,71H             ; g,gr,wb
data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          mov ax,stack
                mov ss,ax

                mov ax,data
                mov ds,ax

                mov ax,0B800H
                mov es,ax
                
                mov bx,0                ; 第几个字符      
                mov di,10*160+36*2      ; 10 行 第 36 个字符 开始显示
                mov si,0                ; 第几行（第几个字符属性）

                mov cx,3                ; 总共 3 行

showMasm:       push bx
                push cx
                push si
                push di

                mov cx,16               ; 总共 16 个字符要显示

                mov dh,ds:[16+si]       ; 设置 字符属性

showRow:        mov dl,ds:[bx]          ; 设置 字符
                mov es:[di],dx                 
                add di,2                ; 指向下一个字符
                inc bx
                loop showRow

                pop di                  ; 执行内循环后 di 又重新指向第一行首位置
                pop si
                pop cx
                pop bx

                add di,160              ; 在这里加一行的字节就可以指向下一行的首位置
                inc si
                loop showMasm

                mov ax,4c00h
                int 21H

code ends

end start
