; 程序介绍：显示在 data 段中的 hex_data 标号处的 十六进制数据，通过 cx 控制多少个字节
; 分析：因为显示一个字符是根据它的 ASCII，而给的数据是本身的数值，所以可以定义 这 16 个字符的 ASCII，然后通过找到这个数据对应的 ASCII 来显示
; 思路：
;   step1: 定义一段内存，保存16个字符的十六进制
;   step2: 读取该数据后，要把两位 十六进制 分开，单独找到其对应的 ASCII
;   step3: 然后显示

assume  ds:data,ss:stack,cs:code

data segment
hex_data        db      4AH,5bH,6cH,7DH
HEX             db      '0123456789ABCDEF'
data ends

stack segment stack
        db      128 dup (0)
stack ends

code segment

start:          mov     ax,stack
                mov     ss,ax
                mov     sp,128
                call    init_reg
                
                mov     bx,0B800H
                mov     es,bx
                mov     di,160*10+10*2

                mov     cx,4
                mov     si,OFFSET hex_data
show_data:      
                call    show_hex
                add     si,1
                add     di,6
                loop    show_data

                mov     ax,4c00H
                int     21H

;==========================================
init_reg:       mov     ax,data
                mov     ds,ax
                mov     si,0
                ret

;==========================================
show_hex:       
                mov     al,ds:[si]              ; get data
                mov     ah,al                   ; 保存多一份，分开得到两个十六进制的 ASCII
                and     al,00001111B            ; 取低4位
                ;and    ah,11110000B            ; 取高4位（注意并不能用此方法得到高4位，因为这样 结果保存在高4位，在寻ASCII 的时候就超出了范围）
                
                shr     ah,1                    ; 直接右移4次，得到高四位
                shr     ah,1                    ; 当然还可以这样： mov  cl,4;   mov ah,cl;  但是要用 cl 寄存器
                shr     ah,1
                shr     ah,1


                mov     bx,0                    
                mov     bl,al
                mov     al,ds:HEX[bx]           ; a:[b] 这样寻址要用相应的寄存器b
                
                mov     bl,ah
                mov     ah,ds:HEX[bx]

                mov     es:[di+2],al
                mov     es:[di+0],ah
                ret

code ends

end start