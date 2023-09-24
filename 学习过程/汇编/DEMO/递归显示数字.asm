; 原理：假设要显示数字 567，要顺序的显示 5, 6, 7 怎么做呢？、
;     肯定是想办法 求余，为什么呢？因为 求余的结果可以保证每次结果都是一位，求商则不行。（显示是一位一位显示的嘛）
;     但是 求余 的话顺序就是 7, 6, 5 了，显示的话就要从起始地址开始减才能正常显示。
;     还可以这么办 --> 只要我可以对 5, 56, 567 进行顺序求余就可以得到 567 了。
;     那怎么对 567 运算得到 5, 56, 567 呢？ --> 求商后 push，这样栈中位置就是 5, 56, 567，就可以按顺序处理了。


assume cs:code,ds:data,ss:stack

data segment

NUMBER          dw      567

data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          mov     ax,stack
                mov     ss,ax
                mov     sp,128
                call    init_reg


                mov     di,160*10+30*2
                mov     ax,NUMBER
                push    ax
                call    show_number

                mov     ax,4c00h
                int     21h

; ======init_reg=======
init_reg:       
                mov ax,data
                mov ds,ax
                
                mov ax,0B800H   ; 显存地址
                mov es,ax

                ret

; ======show_number=======
; * -------------------------------------
; param[IN]     di      set the display offset address
; param[IN]     ax      要显示的数字，只能 push 进来
; * -------------------------------------
show_number:    push    bp
                mov     bp,sp               ; 一定要保存进来时的 sp 位置，因为要用 bp 找参数位置

                cmp     ax,0                ; 求商 直到 商为0
                jne     showNumber
                
                mov     sp,bp               ; 
                pop     bp
                ret

showNumber:     mov     dx,0                ; 32 位除法
                mov     bx,10
                div     bx
                push    ax                  ; 把商 push
                call    show_number         ; 递归 求商并 push，什么时候结束？商 = 0 就结束

                mov     ax,ss:[bp+4]
                mov     dx,0
                mov     bx,10
                div     bx

                add     dl,30H              ; 转换成 ASCII
                mov     es:[di],dl
                add     di,2

                mov     sp,bp
                pop     bp
                ret

code ends

end start

; c 语言版
;void f(int value, int* index);
;
;main()
;{
;    int a = 100;
;    int index = 160*10+40*2;
;    f(a,&index);
;
;
;}
;
;void f(int value, int* index)
;{
;    if(value == 0)
;    {
;        return;
;    }
;    f(value/10,index);
;    *(char far*)(0xB8000000 + (*index)) = (value%10)+0x30;
;    *index += 2;
;}
