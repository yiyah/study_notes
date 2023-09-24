; 输出字符串V1.1（数据的来源放在内存中）
; 程序功能：输出字符串，直到 0
; 思路：通过 jcxz，把数据放到 cl 寄存器中，不是 0 就显示数据；是 0 就结束
;      这次和 V1.0 不一样的是这次的偏移地址是放在内存中，需要通过读取 存储该偏移地址的地址，
;      然后进行赋值给si。

assume cs:code,ds:data,ss:stack

data segment
                ;0123456789ABCDEF
        db      '1. restart pc  ',0
        db      '2. start system',0
        db      '3. show clock  ',0
        db      '4. set clock   ',0
        dw      0,10H,20H,30H
data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          call init_reg
                
                call showAllString

                
                mov ax,4c00h
                int 21H


; =========初始化寄存器==========
init_reg:       mov ax,stack
                mov ss,ax

                mov ax,data
                mov ds,ax

                mov ax,0B800H
                mov es,ax
                ret

; =========显示字符串==========
show_string:    
                push cx                 ; 调用函数前把函数内用到的变量先 push 起来
                push ds
                push es
                push si
                push di

                mov cx,0                ; 数据放到cx进行判断
showString:     mov cl,ds:[si]          ; 数据从哪来
                jcxz show_stringRet     ; 遇到0则返回
                mov es:[di],cl          ; 数据去哪
                add di,2
                inc si                  ; 数据从哪来的偏移地址
                jmp showString

show_stringRet: 
                pop di                  ; 函数执行完后把变量 pop 出来
                pop si
                pop es
                pop ds
                pop cx

                ret

; ==========显示四行字符串===========
showAllString:
                mov cx,4                ; 4行
                mov bx,40H              ; 数据来源的存储地址
                mov di,160*10+30*2
show_allstring: 
                mov si,ds:[bx]          
                call show_string
                add bx,2                ; 取下一行的地址
                add di,160              ; 为下一次显示做准备
                loop show_allstring
                ret
code ends

end start
