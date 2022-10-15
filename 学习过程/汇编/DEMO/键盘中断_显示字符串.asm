; 程序功能：用自己的 键盘中断 来实现在屏幕上显示输入，可以删除，回车结束
; 分析：首先把这个任务分解一下：1. 获取键盘的输入。2. 显示。3. 删除
; 1. 获取键盘的输入
;       通过 int16H 即可
; 2. 显示
;       显示的话就需要：① 字符串的地址 ② 结束符 ③ 显示的位置
;       所以：需要把从键盘获取的输入放到一段内存中，
;       但是这个时候就需要注意，因为是放到内存中，要注意会不会超出自己定义的内存范围
; 3. 删除
;       删除同理，把缓冲区的最后一个字符删除即可，要注意不要超出范围
;       为了能够显示，还需要显示的时候把最后一位也清空，不然的话会继续显示上一次的缓冲区结果。

assume ds:data,ss:stack,cs:code

data segment
STRING  db      128     dup     (0)
data ends

stack segment stack
        db      128     dup     (0)
stack ends

code segment

start:          mov     ax,stack
                mov     ss,ax
                mov     sp,128
                call    int_reg

                call    get_string

                mov     ax,4c00H
                int     21H

;===========================================   
;===========================================
int_reg:        mov     ax,data
                mov     ds,ax
                mov     si,0
                mov     ax,0B800H
                mov     es,ax
                ret

;===================get_string========================
get_string:     mov     si,OFFSET STRING        ; 记录缓冲区的偏移地址
                mov     di,160*10+5*2
                mov     bx,0                    ; 用来作为字符的索引，用于判断内存范围
getString:      mov     ah,0
                int     16H                     ; 获取键盘的输入

                cmp     al,20H                  ; 小于 20H 就不是字母了
                jb      NotChar
                call    push_char
                call    show_string             ; 显示 缓冲区 的字符                    
                call    getString               ; 继续获取键盘输入
getStringRet:   ret

NotChar:        cmp     ah,0EH                  ; 不是字母，还要处理两种功能：删除和回车
                je      Backspace
                cmp     ah,1CH                  ; Enter
                je      getStringRet
                jmp     getString
Backspace:      call    pop_char
                call    show_string             ; 显示 缓冲区 的字符    
                jmp     getString
;==================push_char=========================
push_char:      cmp     bx,126                  ; 判断缓冲区的长度有没有超过
                ja      CharPushRet
                mov     ds:[si+bx],al           ; 把键盘的字符放进缓冲区
                inc     bx
CharPushRet:    ret
;=================pop_char==========================
pop_char:       cmp     bx,0                    ; 判断有没有超出左边界
                je      charpopRet              
                dec     bx
                mov     byte ptr ds:[si+bx],0   ; 删除最后一个字符
charpopRet:     ret

;=================show_string==========================
show_string:    push    dx
                push    si
                push    di

showString:     mov     dl,ds:[si]              ; 把字符放到 dl 中用于下一步判断是不是结束符
                cmp     dl,0
                je      showStringRet
                mov     es:[di],dl              ; 移到显存
                add     di,2
                inc     si
                jmp     showString
showStringRet:  mov     byte ptr es:[di],0      ; 这个语句在删除的时候起关键作用！删除后，马上调用显示。因为 0 在ASCII中就是显示空白，所以遇到0就显示空白
                pop     di                      ; 刚好在 Backspace 的时候把最后一位置 0，然后显示空白
                pop     si
                pop     dx
                ret

code ends
end start