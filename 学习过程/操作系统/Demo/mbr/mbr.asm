org     07C00H
jmp     LABEL_BOOT
BootMessage:    db  "hello world!",0

LABEL_BOOT:
    mov     ax,0B800H
    mov     es,ax
    mov     di,0
    mov     ax,cs
    mov     ds,ax
    mov     si,BootMessage

    call    Disp_Str
    jmp     $

Disp_Str:
    push    cx
DispStr:    
    xor     cx,cx
    mov     cl,[ds:si]
    jcxz    DispStrRet
    mov     ch,02H
    mov     [es:di],cx
    add     di,2
    inc     si
    jmp     DispStr
    
DispStrRet: 
    pop     cx
    ret

times   510-($-$$)  db  0
dw      0xaa55