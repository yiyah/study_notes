; 程序功能：程序提供 4 个功能：分别是 清屏、设置前景色，设置背景色和屏幕向上滚一行。（使用中断调用）
; 通过 ah 选择功能，范围是[0,3]；al 设置颜色
; 先说下调用的思路：现在假设已经分别实现 四个功能 且可正常使用。（特别注意使用中断，因为这样就要把程序拷到一段安全的内存中，然后很多地址都需要根据这个地址去改变）
;       因为我们使用的是定址表来调用函数，所以我们就要在定址表中 确定每个函数的地址，怎么做？
;       首先函数的地址正常来说在 cs 段中，再加上偏移地址，保存在一段地址中，然后 call 这段地址就可以 调用函数了
;       同样，现在就是把这些函数的地址放在一段地址中，难的是如何确定函数的地址，正常来说 "OFFSET 函数标号" 就可以获得函数地址，
;       但是，因为本例中，函数在 中断 里，中断程序又需要拷贝到别的内存中，所以需要 确定拷贝到的内存地址 + 函数的偏移地址（如果可以确保，数据不被覆盖也可以直接 OFFSET 的）
;       就这样就可以确定了 一段内存中 都保存了 所有函数的地址，称 ADDRESSTABLE
;   接下来就是怎么根据功能号 来 call 到 定址表中函数的地址:
;       因为功能号是 0,1,2,3 而定址表中的 IP 地址间隔是 2，所以，功能号自加本身就可以得到，相对定址表的偏移地址
;       但是，我要 call 的是 定址表中的函数地址，所以还需要 拷贝到的内存地址 + 定址表的偏移地址 + 函数地址
; 然后谈谈功能实现：
;   设置前景颜色还好理解，背景颜色说一下：因为背景颜色是字节的高 4 位，所以需要把颜色的值al，左移4位 才可以放到 高 4 位。
;   然后，设颜色前还得清空之前的设置，通过 or 设上去
; 还有一个就是 屏幕向上滚一行：
;   思路就是：一行一行复制，重复 24行；先从第二行开始 复制到第一行。

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
                
                call    cpy_new_int7CH
                call    set_vector
                

                mov     al,02H
                mov     ah,1
                int     7CH

                mov     ax,4c00H
                int     21H
; ===================END OF PROGRAM============================
; ===================END OF PROGRAM============================
; ===================END OF PROGRAM============================

; =================init_reg======================
init_reg:       mov     ax,data
                mov     ds,ax
                mov     si,0
                ret

; =================set vector======================
set_vector:     mov     ax,00H
                mov     es,ax

                cli
                mov     word ptr es:[7CH*4],7E00H
                mov     word ptr es:[7CH*4+2],0 
                sti

                ret

; =================new int 7CH======================
new_int7CH:     jmp     newint7CH

ADDRESSTABLE    dw      7E00H + OFFSET clear_screen    - OFFSET new_int7CH
                dw      7E00H + OFFSET set_pre_screen  - OFFSET new_int7CH
                dw      7E00H + OFFSET set_back_screen - OFFSET new_int7CH
                dw      7E00H + OFFSET rollup_1row     - OFFSET new_int7CH

newint7CH:      mov     bx,0
                mov     es,bx

                mov     bl,ah
                add     bx,bx                                               ; 功能号 自家本身
                add     bx,7E00H + OFFSET ADDRESSTABLE - OFFSET new_int7CH
                call    word ptr es:[bx]

                iret

; =================1: clear screen======================
clear_screen:   
                push    ax
                push    cx
                push    es
                push    di

                mov     ax,0B800H
                mov     es,ax
                mov     di,0

                mov     ax,0
                mov     cx,2000         ; 80*25*2 = 4000

clearScreen:    mov     es:[di],ax
                add     di,2
                loop    clearScreen

                pop     di
                pop     es
                pop     cx
                pop     ax
                ret

; =================2: set pre screen======================
set_pre_screen: ; data from al
                push    bx
                push    cx
                push    es
                push    di

                mov     bx,0B800H
                mov     es,bx
                mov     di,1
                
                mov     cx,2000
setPreScreen:   and     byte ptr es:[di],11111000B              ; clear origin color
                or      byte ptr es:[di],al                     ; set color
                add     di,2
                loop    setPreScreen
                
                pop     di
                pop     es
                pop     cx
                pop     bx

                ret

; =================3: set back screen======================
set_back_screen: ; data from al
                push    bx
                push    cx
                push    es
                push    di

                mov     bx,0B800H
                mov     es,bx
                mov     di,1
                
                mov     cl,4
                shl     al,cl

                mov     cx,2000
setBackScreen:  and     byte ptr es:[di],10001111B              ; clear origin color
                or      byte ptr es:[di],al                     ; set color
                add     di,2
                loop    setBackScreen
                
                pop     di
                pop     es
                pop     cx
                pop     bx

                ret

; =================4: roll up 1 row ======================
rollup_1row:    
                push    ax
                push    cx
                push    ds
                push    es
                push    di
                push    si

                mov     ax,0B800H
                mov     ds,ax
                mov     si,160
                mov     es,ax
                mov     di,0

                mov     cx,80*24
                cld
                rep     movsw
                
                mov     di,160*24
                mov     cx,80
                mov     ax,0700H
setBlankRow:    mov     es:[di],ax
                add     di,2
                loop    setBlankRow

                pop     si
                pop     di
                pop     es
                pop     ds
                pop     cx
                pop     ax

                ret

new_int7CH_end: nop
; =================copy int 7CH======================
cpy_new_int7CH: push    cx
                mov     ax,code
                mov     ds,ax
                mov     si,OFFSET new_int7CH    ; data from where
                
                mov     ax,00H
                mov     es,ax
                mov     di,7E00H                ; data go where

                mov     cx,OFFSET new_int7CH_end - OFFSET new_int7CH
                cld
                rep     movsb
                pop     cx
                ret
code ends

end start
