; 分析：发生键盘中断的时候，系统应该是通过 中断向量表 执行本来的 int9,那么我们只要把中断向量表的 int9 的入口地址改成是我们的中断地址就可以了
; 但是因为键盘中断的程序涉及到太多的硬件，我们很难搞，于是我们需要在我们自己的中断程序里 调用 本来的中断程序 来识别 键盘的输入
; 思路：
;       step1: 实现自己的中断程序，在里面调用本来的中断程序来识别键盘输入
;       step2: 保存本来的中断入口地址
;       step3: 设置入口地址为自己的中断程序
;       step4: 改为原来的入口地址


assume  ds:data,ss:stack,cs:code

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

                call    cpy_new_int9
                call    save_old_vector
                call    set_new_vector

testA:          mov     ax,1000
                jmp     testA
                
                call    resume_old_vector

                mov     ax,4c00H
                int     21H

;==========================================
init_reg:       mov     ax,data
                mov     ds,ax
                mov     si,0
                ret

;==========================================
new_int9:       

                in      al,60H
                pushf                           ; 模拟调用 int9
                call    dword ptr cs:[200H]     ; 因为进入这里也是由系统调用中断，所以相关的标志位已经设置过了
                                                ; 但是要注意，因为旧的int9的地址也是保存在 0:200H，而新的 int9 的地址是保存在0:7E00H
                                                ; 所以 CS 是刚好可以
                cmp     al,3BH                  ; F1
                jne     int9Ret
                call    change_screen_color

int9Ret:        iret

;==========================================
change_screen_color:
                mov     ax,0B800H
                mov     es,ax
                mov     di,1

                mov     cx,2000         ; 80*25*2 = 4000 byte

change_color:   inc     byte ptr es:[di]
                add     di,2
                loop    change_color
                ret

new_int9_end:   nop


;==========================================
resume_old_vector:
                mov     ax,0
                mov     es,ax
                mov     si,200H
                mov     di,9*4
                cli
                push    es:[si]
                pop     es:[9*4]
                push    es:[si+2]
                pop     es:[9*4+2]
                sti
                ret

;==========================================
save_old_vector:
                mov     ax,0
                mov     es,ax

                cli
                push    es:[9*4]
                pop     es:[200H]        ; ip
                push    es:[9*4+2]
                pop     es:[202H]      ; cs
                sti
                ret


;==========================================
set_new_vector: 
                mov     ax,0
                mov     ds,ax
                cli
                mov     word ptr ds:[9*4],7E00H
                mov     word ptr ds:[9*4+2],0
                sti
                ret

;==========================================
cpy_new_int9:   mov     ax,code
                mov     ds,ax
                mov     si,OFFSET new_int9

                mov     ax,0
                mov     es,ax
                mov     di,7E00H

                mov     cx,OFFSET new_int9_end - OFFSET new_int9
                cld
                rep     movsb
                ret

code ends

end start