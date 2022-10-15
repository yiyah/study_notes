; 程序功能：输出三行不同颜色的 字符串 V1.1
; 该程序是 原来的升级版，通过 call 指令来调用，可以很方便的增加数据来显示
;       通过 bx 寄存器来指向内存的字符串的偏移地址，
;           di 寄存器来设置显示在哪一行


assume cs:code,ds:data,ss:stack

data segment
                ;0123456789ABCDEF
        db      'welcome to masm!'
        db      02H,24H,71H             ; g,gr,wb
        db      13 dup (0)              ; 此处的作用是补全 16 字节，方便下面程序的处理
        db      'aaaaaaaaaaaaaaaa'
        db      'yyyyyyyyyyyyyyyy'
data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          

                call init_reg           ; 初始化寄存器，即数据的来源和去向

                mov bx,0                ; 第几个字符      
                mov di,10*160+36*2      ; 10 行 第 36 个字符 开始显示
                call show_masm


                mov bx,32                ; 第几个字符      
                mov di,4*160+36*2      ; 10 行 第 36 个字符 开始显示
                call show_masm

                mov bx,48                ; 第几个字符      
                mov di,15*160+36*2      ; 10 行 第 36 个字符 开始显示
                call show_masm

                mov ax,4c00h
                int 21H


; ========================================
init_reg:       mov ax,stack
                mov ss,ax

                mov ax,data             ; 设置寄存器
                mov ds,ax

                mov ax,0B800H
                mov es,ax
                ret

; ========================================

show_masm:      
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
                ret
code ends

end start
