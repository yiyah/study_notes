# CMOS

## 简介

* CMOS 是一块 RAM 芯片，是由 纽扣电池 供电的。所以掉电后保存的信息还是保留的。
* 大小是 128 Bytes，其中 0 ~ DH 的地址保存的是时钟的信息，其余大部分都是保存系统信息
  * 关于时间信息的内存地址

    |  time   | s | m | h | d | m | y |
    |  ----   | - | - | - | - | - | - |
    | address | 0 | 2 | 4 | 7 | 8 | 9 |

    > 读出来是什么格式的呢？是 BCD 码！
      比如：读 秒 的单元，al = 0011 0010 --> 表示 32 秒

* 有两个端口：
  * 地址端口：70H
  * 数据端口：71H

## Coding

1. 读取 CMOS 的 2 号单元内容

    ```asm
    mov     al,2        ; 8位端口用 al
    out     70H,al      ; 通知 CMOS 我要操作 2 号单元
    in      al,71H      ; 从数据端口 读取
    ```

2. 向 CMOS 2 号单元写入内容

    ```asm
    mov     al,2
    out     70H,al      ; 通知 CMOS 我要操作 2 号单元
    mov     al,0        ; 准备数据
    out     71H,al      ; 写入数据
    ```

3. 读取 秒，并把 十位 放到 ah，个位 放到 al

    ```asm
    mov     al,0
    out     70H,al
    in      al,71H          ; had got the second

    mov     ah,al           ; 赋值给 ah，单独处理
    shr     ah,1
    shr     ah,1
    shr     ah,1
    shr     ah,1            ; 4 次右移得到【十位】，并且 高4位 是0
    and     al,00001111B    ; and 运算直接得到【个位】，并且 高4位 是0
    ```
