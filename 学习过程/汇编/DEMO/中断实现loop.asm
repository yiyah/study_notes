; 程序功能：7C号中断实现 loop指令，在屏幕中间显示一行 ！
; 思路：在中断程序里通过对cx自减，判断是否为0，不为0则把ip修改为 标号地址
; 标号地址怎么获得？通过 ip+偏移地址获得

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
                call    cpy_new_int7cH
                call    set_vec

                mov     dx,OFFSET show_char - OFFSET show_char_end  ; 得到 ip 的偏移地址（往回跳多少）  === 关键点：要好好理解
                mov     cx,80                                       ; 显示多少个字符
                mov     bh,02H                                      ; 字符颜色
                mov     bl,'!'                                      ; 字符
show_char:      mov     es:[di],bx                                  ; 放到显存
                add     di,2                                        ; 显示下一个
                int     7CH                                         ; 相当于 loop show_char
show_char_end:  nop
                mov     ax,4c00h
                int     21H

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;               函数定义
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

; =========初始化寄存器==========
init_reg:       mov     ax,data
                mov     ds,ax
                mov     si,0

                mov     ax,0B800H
                mov     es,ax
                mov     di,160*12
                ret

; =========设置中断向量表==========
set_vec:
                push    ax
                push    es
                mov     ax,0
                mov     es,ax
                cli
                mov     word ptr es:[7CH*4],7e00H
                mov     word ptr es:[7CH*4+2],0
                sti

                pop     es
                pop     ax
                ret

; =========自定义中断服务==========
new_int7c:      push    bp                      ; 栈的情况：bp ip    cs      pushf
                mov     bp,sp                   ; ss:[sp] 不能直接赋值，所以需要 bp 来做中间人
                dec     cx
                jcxz    new_int7c_RET           ; cx 为0 则退出
                add     ss:[bp+2],dx            ; ip = ip + 偏移地址，后 ip 指向 show_char 标号  === 关键点：要好好理解
                ; 这里要理解为什么 改栈中 的 ip，因为要返回到 show_char 继续执行，ip 的地址要往回跳（进中断时IP已经指向下一条指令了，即 nop）
                ; 而往回跳怎么计算呢？首先，计算往回跳多少 --> 从当前ip指向的地址开始计算（假设9），算到要开始执行的地址（假设2），即往回跳 7 个字节
                ; 可以加一个负数，也可以减一个正数。这里选择加一个负数了。
new_int7c_RET:  pop     bp
                iret
new_int7c_end:  nop

; =========拷贝中断至安全地址==========
cpy_new_int7cH:
                push    ax
                push    ds
                push    es
                push    si
                push    di

                mov     ax,cs
                mov     ds,ax
                mov     si,OFFSET new_int7c

                mov     ax,0
                mov     es,ax
                mov     di,7e00H

                mov     cx,OFFSET new_int7c_end - OFFSET new_int7c
                cld
                rep     movsb

                pop     di
                pop     si
                pop     es
                pop     ds
                pop     ax
                ret

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

code ends

end start