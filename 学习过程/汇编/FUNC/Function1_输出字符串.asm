
; * -------------------------------------
; * @brief      输出字符串 V1.0
; * @note       给出字符串首地址，遇 0 停止输出
; * @param      dh 行号，取值范围：[0,24]
; * @param      dl 列号，取值范围：[0,79]
; * @param      bl 颜色
; * @param      ds:si 指向字符串首地址
; * @usage      mov dh,10       ; 行号
;               mov dl,30       ; 列号
;               mov bl,02H      ; 颜色
;               mov si,0        ; 字符串的偏移地址
;               call show_str
; * -------------------------------------
show_str:       push    ax
                push    bx
                push    cx
                push    dx
                push    ds
                push    es
                push    si
                push    di

                mov     ax,0B800H
                mov     es,ax           ; 设置数据目的地

                ; 求行偏移
                mov     ax,160
                mul     dh              ; 此时的运算都是临时运算
                mov     cx,ax           ; 为的是求出 目的地的偏移地址，然后放到 di
                ; 求列偏移
                mov     ax,2
                mul     dl
                add     ax,cx
                mov     di,ax           ; 求目的地偏移地址
                                        ; 到这里除了 si,di,bl 外的寄存器都可以使用
showStr:        mov     cx,0            ; 置0是为了用 jcxz 判断是否 结束
                mov     cl,ds:[si]      ; 要显示的数据
                jcxz    show_strRet     ; 遇到 0 就返回
                mov     ch,bl           ; 设置颜色
                mov     es:[di],cx      ; 显示
                inc     si              ; 指向下一个要显示的地址
                add     di,2            ; 指向下一个目的地
                jmp     showStr

show_strRet:    ; mov byte ptr es:[di],0    ; 这句看情况加，作删除的时候有用
                pop     di
                pop     si
                pop     es
                pop     ds
                pop     dx
                pop     cx
                pop     bx
                pop     ax
                ret
; ==============End of show_str=======================


; 这个函数修改的地方是用cmp指令来代替jcxz
; * -------------------------------------
; * @brief      输出字符串 V1.1
; * @note       给出字符串首地址，遇 0 停止输出
; * @param      dh 行号，取值范围：[0,24]
; * @param      dl 列号，取值范围：[0,79]
; * @param      bl 颜色
; * @param      ds:si 指向字符串首地址
; * @usage      mov dh,10       ; 行号
;               mov dl,30       ; 列号
;               mov bl,02H      ; 颜色
;               mov si,0        ; 字符串的偏移地址
;               call show_str
; * -------------------------------------
show_str:       push    ax
                push    bx
                push    cx
                push    dx
                push    ds
                push    es
                push    si
                push    di

                mov     ax,0B800H
                mov     es,ax           ; 设置数据目的地

                ; 求行偏移
                mov     ax,160
                mul     dh              ; 此时的运算都是临时运算
                mov     cx,ax           ; 为的是求出 目的地的偏移地址，然后放到 di
                ; 求列偏移
                mov     ax,2
                mul     dl
                add     ax,cx
                mov     di,ax           ; 求目的地偏移地址
                                        ; 到这里除了 si,di,bl 外的寄存器都可以使用
showStr:        mov     ax,0            ; 置0是为了 cmp 指令作比较时 ah 不影响 al 的结果
                mov     al,ds:[si]      ; 要显示的数据
                cmp     ax,0            ; 作比较
                je      show_strRet     ; 作判断，遇到 0 就返回
                mov     ah,bl           ; 设置颜色
                mov     es:[di],ax
                inc     si              ; 指向下一个要显示的地址
                inc     di
                inc     di              ; 两次 inc 是为了指向下一个目的地
                loop    showStr

show_strRet:    ; mov byte ptr es:[di],0    ; 这句看情况加，作删除的时候有用
                pop     di
                pop     si
                pop     es
                pop     ds
                pop     dx
                pop     cx
                pop     bx
                pop     ax
                ret
; ==============End of show_str=======================