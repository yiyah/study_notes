; 输出字符串V1.0（数据的来源通过寄存器设置）
; 程序功能：输出字符串，直到 0
; 思路：通过 jcxz，把数据放到 cl 寄存器中，不是 0 就显示数据；是 0 就结束

assume cs:code,ds:data,ss:stack

data segment
                ;0123456789ABCDEF
        db      '1. restart pc  ',0
        db      '2. start system',0
        db      '3. show clock  ',0
        db      '4. set clock   ',0

data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          call init_reg
                
                
                mov si,0                ; 设置字符串的起始地址
                mov di,160*10+30*2      ; 数据去哪，偏移地址
                call show_string

                mov si,16
                mov di,160*11+30*2
                call show_string

                mov si,32
                mov di,160*12+30*2
                call show_string
                
                mov si,48
                mov di,160*13+30*2
                call show_string
                
                
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
                mov cx,0                ; 数据放到cx进行判断
                mov cl,ds:[si]          ; 数据从哪来
                jcxz show_stringRet     ; 遇到0则返回
                mov es:[di],cl          ; 数据去哪
                add di,2
                inc si                  ; 数据从哪来的偏移地址
                jmp show_string

show_stringRet: ret

code ends

end start
