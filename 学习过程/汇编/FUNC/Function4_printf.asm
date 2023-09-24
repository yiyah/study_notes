; * -------------------------------------
; * @brief      汇编模拟 c 的 printf
; * @note       printf("this is test %c %c is test %c --> num %d",'a', 'b', 'c', 6);
;               思路：
;                   因为调用 printf 先 push 参数，而进去 printf 后会用 bp 记录 sp 的位置，
;               所以每个参数的位置和 bp 相关，同时参数个数可以通过 % 来判断
;
; * @param[IN]  di 显示的位置
; * @param[IN]  bl 字体颜色
; * @usage      mov     ax,OFFSET STRING    ; 这个 STRING 是字符串的地址，必须有（可以没有控制符）
;               push    ax
;               mov     di,160*10+30*2
;               mov     bl,02H
;               call    asm_printf
; * -------------------------------------
asm_printf:     push    bp                  ; 模拟 c 编译
                mov     bp,sp               ; 最后 pop 需要注意什么时候归还 sp
                push    ax                  ; 因为 bp 记录了刚进来的 sp 位置（也是必须进来后就记录，因为为了取数据方便）
                push    bx                  
                push    si
                push    es
                push    di

                mov     ax,0B800H
                mov     es,ax
                mov     si,ss:[bp-4]        ; get the string's address
                mov     ah,bl               ; color
                mov     bx,bp               
                add     bx,6                ; save the first parameter
ASMPrintf:      mov     al,ds:[si]
                cmp     al,0
                je      asm_printfRet
                cmp     al,'%'              
                je      asm_deal_control    ; 遇到输出控制符
                mov     es:[di],ax
                add     di,2
                inc     si
                jmp     ASMPrintf

asm_deal_control:
                cmp     byte ptr ds:[si+1],'c'
                je      asm_show_char
                cmp     byte ptr ds:[si+1],'d'
                je      asm_show_num

asm_show_char:  mov     al,ss:[bx]          ; 把 ss:[bx] 指向的参数拿出来
                mov     es:[di],ax
                add     si,2                ; 需要跳过 %c，所以 +2
                add     di,2
                add     bx,2                ; 指向下一个参数，为下次调用准备
                jmp     ASMPrintf

asm_show_num:   mov     al,ss:[bx]
                add     al,30H
                mov     es:[di],ax
                add     si,2
                add     di,2
                add     bx,2
                jmp     ASMPrintf

asm_printfRet:  pop     di              ; 如果在此之前归还 sp 会导致 sp 提前指向了进来的时候的位置
                pop     es              ; 但是这些 push 都是基于进来后的 sp 位置的，就会出现 pop 的位置出错（往高地址取了，实际上这些值保存在sp前的低地址）
                pop     si              ; 所以先 pop，再后面 归还 sp
                pop     bx
                pop     ax
                mov     sp,bp           ; <--
                pop     bp
                ret
; ==============End of asm_printf=======================
