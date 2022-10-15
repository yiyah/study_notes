; 程序功能：把数据段中的数据按照要求转换成对应大小写，并且放在栈段中
; 如果像常规的转换，需要判断当前字母是大写还是小写，比较慢；通过观察字母的 ASCII, 发现其规律，使用逻辑运算来进行转换，非常快！
assume cs:code,ds:data,ss:stack

data segment
        db      'BaSic'         ; 转换成大写
        db      'iNFOrmATIon'   ; 转换成小写
data ends

stack segment stack
        dw      0,0,0,0,0,0,0,0
        dw      0,0,0,0,0,0,0,0
stack ends

code segment

start:  mov ax,ss
            mov ss,ax
            mov sp,20H      ; 设置栈段

            mov ax,data
            mov ds,ax
            mov bx,0        ; 设置数据段

            mov cx,5
            mov ax,0

upletter:   mov al,ds:[bx]
            and al,11011111B    ; 置0，转大写
            push ax             ; push 指令对 字（两个字节）进行操作
            inc bx
            loop upletter

            mov cx,11
lowletter:  mov al,ds:[bx]
            or  al,00100000B    ; 置1，转小写
            push ax
            inc bx
            loop lowletter

            mov ax,4c00H
            int 21H

code ends


end start