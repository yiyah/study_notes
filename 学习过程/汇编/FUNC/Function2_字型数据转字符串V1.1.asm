; 更新说明：
;   此函数 修复了调用后 di 会改变的问题
;
; * -------------------------------------
; * @brief      把字型数据转换成 ASCII V1.1
; * @note       给出字型数据的地址，程序把转换后的ASCII 放到 es:di 中
; * @param      si ds:si 指向 待转换 的字型数据
; * @param      di es:di 指向 转换后的数据保存的首地址，注意预留一位结束符0
; * @usage      mov ax,string
;               mov es,ax       ; es 指向保存的地址
;               mov si,0
;               call wtoc
; * -------------------------------------
wtoc:           push    ax
                push    bx
                push    cx
                push    dx
                push    si
                push    di

                mov     ax,ds:[si]      ; 被除数低16位
                mov     dx,0            ; 被除数高16位，因为是字型，高16位用不到。但是商的结果可能大于255所以用16位除法
                mov     bx,10           ; 除数
                mov     si,0            ; si此时用于计数，保存字型数据有多少位
short_div:      div     bx
                add     dl,30H          ; 转 ASCII
                push    dx              ; 保存
                inc     si              ; 保存位数
                mov     cx,ax           ; 把商放到cx，用于判断是否结束
                jcxz    short_divRet
                mov     dx,0
                jmp     short_div

short_divRet:   mov     cx,si           ; 把位数给 cx
shortDivRet:    pop     dx
                mov     es:[di],dl
                inc     di
                loop    shortDivRet

                pop     di
                pop     si
                pop     dx
                pop     cx
                pop     bx
                pop     ax
                ret
; ==============End of wtoc=======================