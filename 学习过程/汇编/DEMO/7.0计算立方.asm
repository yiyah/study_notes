assume cs:code,ds:data,ss:stack

data segment

        db 128 dup (0)
data ends

stack segment stack
        db 128 dup (0)
stack ends

code segment

start:          mov ax,stack
                mov ss,ax
                mov sp,128


                call init_reg

                mov bx,50       ; 参数，要计算的值
                call get_cube   ; 16位乘法

                mov ax,4c00h
                int 21h

; ======init_reg=======
init_reg:       
                mov ax,data
                mov ds,ax

                ret

get_cube:       mov ax,bx
                mul bx
                mul bx
                ret

code ends

end start
