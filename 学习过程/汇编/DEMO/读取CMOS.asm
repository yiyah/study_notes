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

                call    read_CMOS

                mov     ax,4c00H
                int     21H

;==========================================
init_reg:       mov     ax,data
                mov     ds,ax
                mov     si,0
                ret

;==========================================
; cl: 地址
read_CMOS:      mov     al,cl
                out     70H,al
                in      al,71H
                mov     di,160*12+30*2
                call show
                ret

;==========================================
show:           mov     ax,0B800H
                mov     es,ax
                ;mov     di,160*12+30*2 ; 由外部决定

                mov     es:[di],al
                mov     al,02H
                mov     es:[di+1],al
                ret

code ends

end start