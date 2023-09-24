程序功能：把内存中的数求立方后，放到后面的内存中
assume cs:code,ds:data,ss:stack

data segment

        dw 11,22,33,44,55,66,77,88
        dd 0,0,0,0,0,0,0,0
data ends

stack segment stack
        db 128 dup (0)
stack ends

code segment

start:          mov ax,stack
                mov ss,ax
                mov sp,128


                call init_reg
                
                call number_cube

                mov ax,4c00h
                int 21h

; ======init_reg=======
init_reg:       
                mov ax,data
                mov ds,ax
                
                mov ax,data
                mov es,ax

                ret

; ======get_cube=======
get_cube:       mov ax,bx
                mul bx
                mul bx
                ret

; ======number_cube=======
number_cube:    
                mov si,0        ; 第几个数（字型）
                mov di,16
                mov cx,8
                
numberCube:     mov bx,ds:[si]
                call get_cube
                mov es:[di+0],ax
                mov es:[di+2],dx

                add si,2
                add di,4
                loop numberCube
                ret
code ends

end start
