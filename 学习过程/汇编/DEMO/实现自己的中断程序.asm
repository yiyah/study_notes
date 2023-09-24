;实现自己的中断程序的思路:
;step1: 先编写中断程序
;step2: 把中断程序复制到一段安全的内存空间
;step3: 修改中断向量表，把要中断的中断号的地址修改为中断程序的起始地址

assume ds:data,ss:stack,cs:code

data segment
        db      128 dup (0)
data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          mov     ax,stack
                mov     ss,ax
                mov     sp,128
                call    init_reg

                call    cpy_new_int0
                call    set_new_intVector
                int     0

                mov     ax,4c00H
                int     21H

;==========================================
init_reg:       mov     ax,data
                mov     ds,ax
                mov     si,0
                ret

;==========================================
; Desc: 修改中断向量表，中断号0的地址
set_new_intVector:
                mov     ax,0
                mov     es,ax

                cli
                mov     word ptr es:[0*4],7E00H         ; ip
                mov     word ptr es:[0*4+2],0           ; cs
                sti

                ret

;==========================================
; 自己编写的中断程序，作用是显示全屏的 !
new_int0:       push    ax
                push    cx
                push    es
                push    di

                mov     ax,0B800H
                mov     es,ax
                mov     di,0
                mov     cx,2000
                
                mov     ah,02H
                mov     al,'!'

show_ascii:     mov     es:[di],ax
                add     di,2
                loop    show_ascii

                pop     di
                pop     es
                pop     cx
                pop     ax

                iret
new_int0_end:   nop

;==========================================
; Desc: 把自己编写的中断程序 copy 到一个安全的内存中 0:7E00H
cpy_new_int0:   mov     ax,cs
                mov     ds,ax
                mov     si,OFFSET new_int0      ;设置要复制的数据的地址（数据从哪来）
                
                mov     ax,0
                mov     es,ax
                mov     di,7E00H                ; 数据到哪去

                mov     cx,OFFSET new_int0_end - new_int0
                cld
                rep     movsb
                ret


code ends

end start
