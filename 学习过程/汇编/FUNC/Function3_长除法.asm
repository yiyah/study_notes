; * -------------------------------------
; * @brief      16位除法，防溢出
; * @note       div 运算的商保存在 ax 中，但是商如果超过16位就会溢出
;               本函数可以解决这个问题，利用如下公式：
;                       X/N = int(H/N)*65536 + [rem(H/N)*65536+L]/N
;                       X:被除数；N: 除数；H:被除数的高16位；L:被除数的低16位
;                       int(H/N): 得到商
;                       rem(H/N): 得到余数
; * @param      ax dword型数据的 低16位
; * @param      dx dword型数据的 高16位
; * @param      cx 除数
; * @return     ax 商的低16位
;               dx 商的高16位
;               cx 余数
; * @usage      mov ax,4240H
;               mov dx,0FH
;               mov cx,10
;               call long_div   ; 实现的功能是 1000000/10=100000
; * -------------------------------------
long_div:       push bx
                mov bx,ax       ; bx 保存 被除数的低16位
                mov ax,dx       ; 把高16位放到 ax 中作除法
                mov dx,0
                div cx          ; 此时 ax = 商, dx = 余数（都是高16位的结果）
                push ax         ; 商的高16位
                mov ax,bx       ; 因为余数在dx，就相当于乘以了65536了，把低16位放到ax，相当于加了低16位
                div cx          ; 此时，ax 保存商的低16位。dx是余数
                mov cx,dx       ; cx 保存余数
                pop dx          ; 直接把商的高16位放到 dx
                pop bx
                ret
; ==============End of long_div=======================
