; 程序功能：按下小写的 'r' 'g' 'b' 就可以给字体设置相应颜色
; 程序分析：在此 DEMO 中，使用 int 16H 中断（注意功能号的设置）来获取键盘的输入（扫描码+ascii），之前的 int 9H 是通过端口来获取键盘的输入（扫描码）
; 然后设置字体颜色的时候有一个小技巧：就是先 mov ah,1。如果是 'r'，跳到相应位置后会 shl 两次，完成红色的mask设置
; 在最后处理蓝色的条件中，再根据这个 mask 来给字体设置颜色。

assume ds:data,ss:stack,cs:code

data segment
        db      128     dup     (0)
data ends

stack segment stack
        db      128     dup     (0)
stack ends

code segment

start:          mov     ax,stack
                mov     ss,ax
                mov     sp,128
                call    int_reg

s:              call    set_color           ; 调用设置字体颜色的程序
                jmp     s                   ; 死循环
    
                mov     ax,4c00H
                int     21H

;===========================================   
;===========================================
int_reg:        mov     ax,data
                mov     ds,ax
                mov     si,0
                ret

;===========================================
set_color:      mov     ah,0                ; 功能号
                int     16H                 ; 调用 16H 的 0 功能中断
                ; 中断返回：ah = 扫描码 al = ASCII
                ; 因为我们直接根据键盘的值al来判断，所以不需要扫描码ah
                mov     ah,1                ; 这里有一个技巧
                cmp     al,'r'              ; 如果是 `r`,就执行 两条 shl 的指令，就设成 红色了
                je      set_red
                cmp     al,'g'
                je      set_green
                cmp     al,'b'              ; 如果是 `b`,就跳过 两条 shl 的指令
                je      set_blue
                
set_red:        shl     ah,1
set_green:      shl     ah,1

set_blue:       mov     bx,0B800H
                mov     es,bx
                mov     cx,2000
                mov     di,1
setColor:       and     byte ptr es:[di],11111000B      ; 清颜色设置
                or      byte ptr es:[di],ah             ; 设置颜色
                add     di,2
                loop    setColor

                ret
code ends
end start