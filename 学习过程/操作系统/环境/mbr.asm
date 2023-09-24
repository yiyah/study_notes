org     07c00H
mov     ax,cs
mov     ds,ax
mov     es,ax
call    DispStr
jmp     $

DispStr:
        mov     ax,BootMessage
        mov     bp,ax
        mov     cx,16
        mov     ax,01301H
        mov     bx,000cH
        mov     dl,0
        int     10H
        ret
BootMessage:    db      "Hello,OS world!"
times   510-($-$$)      db      0
dw      0xaa55
