; * -------------------------------------
; * @brief      把字型数据转换成 ASCII V1.0
; * @note       给出字型数据的地址，程序把转换后的ASCII 放到 es:di 中
;               - 此方法会修改 di 的值，如：字型数据是 1234，di = 10
;                 调用本函数后，di = 6
; * @param      si ds:si 指向 待转换 的字型数据
; * @param      di es:di 指向 转换后的数据放到哪
; * @usage      mov ax,string
;               mov es,ax       ; es 指向保存的地址
;               mov di,10
;               mov si,0
;               call wtoc
; * -------------------------------------
wtoc:           push    ax
                push    bx
                push    cx
                push    dx

                mov     ax,ds:[si]      ; 被除数低16位
                mov     dx,0            ; 被除数高16位，因为是字型，高16位用不到。但是商的结果可能大于255所以用16位除法
                mov     bx,10           ; 除数
short_div:      div     bx
                add     dl,30H          ; 转 ASCII
                sub     di,1            ; 个位放最后（栈的思想）
                mov     es:[di],dl      ; 保存
                mov     cx,ax           ; 把商放到cx，用于判断是否结束
                jcxz    short_divRet
                mov     dx,0
                jmp     short_div

short_divRet:   pop     dx
                pop     cx
                pop     bx
                pop     ax
                ret
; ==============End of wtoc=======================
