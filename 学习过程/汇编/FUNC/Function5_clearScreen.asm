; * @brief      清屏
; * @usage      call    clear_screen
; * -------------------------------------
clear_screen:   push    ax
                push    dx
                push    cx
                push    es
                push    di
                mov     ax,0B800H
                mov     es,ax
                mov     cx,2000
                mov     di,0
                mov     dx,0700H
clearScreen:    mov     es:[di],dx
                add     di,2
                loop    clearScreen
                
                pop     di
                pop     es
                pop     cx
                pop     dx
                pop     ax
                ret
; ==============End of clear_screen=======================
