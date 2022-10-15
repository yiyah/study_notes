# ELF

ELF 是指 `Executable and Linkable Foramt`，是 LINUX 下最常用的可执行文件格式。

先看一个 ELF 的 二进制内容
![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20220610220554.png)

## ELF Header

```c
#define EI_NIDENT (16)

typedef struct
{
  unsigned char e_ident[EI_NIDENT]; /* Magic number and other info */
  Elf32_Half    e_type;             /* Object file type */
  Elf32_Half    e_machine;          /* Architecture */
  Elf32_Word    e_version;          /* Object file version */
  Elf32_Addr    e_entry;            /* Entry point virtual address */
  Elf32_Off     e_phoff;            /* Program header table file offset */
  Elf32_Off     e_shoff;            /* Section header table file offset */
  Elf32_Word    e_flags;            /* Processor-specific flags */
  Elf32_Half    e_ehsize;           /* ELF header size in bytes */
  Elf32_Half    e_phentsize;        /* Program header table entry size */
  Elf32_Half    e_phnum;            /* Program header table entry count */
  Elf32_Half    e_shentsize;        /* Section header table entry size */
  Elf32_Half    e_shnum;            /* Section header table entry count */
  Elf32_Half    e_shstrndx;         /* Section header string table index */
} Elf32_Ehdr;
// Elf32_Half 是 2 字节外，其他全是 4 字节
// 从定义可以看到 ELF Header 其实是固定的 size: 16 + 8*2 + 5*4 = 52 = 0x34 Bytes
// 但这些数据类型可能在不同 位数的 cpu 里有所不同，但 32bit 以下的 CPU 应该是一样的
```

解释如下

```shell
e_ident     7F 45 4C 46 01 01 01 00 00 00 00 00 00 00 00 00
e_type      02 00       # 文件类型，2就是可执行文件
e_machine   03 00       # 3 就是 Intel 80386
e_version   01 00 00 00
e_entry     00 81 04 08 # 程序的入口地址：0x08048100
e_phoff     34 00 00 00 # program header table 在文件中的 offset
e_shoff     78 10 00 00 # Section header table 在文件中的 offset
e_flags     00 00 00 00
e_ehsize    34 00       # ELF header size
e_phentsize 20 00       # program header table 中每个条目的大小（一个 program header）
e_phnum     03 00       # program header table 中有多少个条目
e_shentsize 28 00       # section header table 中每个条目的大小
e_shnum     08 00       # section header table 中有多少个条目
e_shstrndx  07 00
```

## Program Header Table

Program header 描述的是系统准备程序运行的所需的一个段或其他信息。比如：

```c
typedef struct
{
  Elf32_Word    p_type;         /* Segment type */
  Elf32_Off     p_offset;       /* Segment file offset */
  Elf32_Addr    p_vaddr;        /* Segment virtual address */
  Elf32_Addr    p_paddr;        /* Segment physical address */
  Elf32_Word    p_filesz;       /* Segment size in file */
  Elf32_Word    p_memsz;        /* Segment size in memory */
  Elf32_Word    p_flags;        /* Segment flags */
  Elf32_Word    p_align;        /* Segment alignment */
} Elf32_Phdr;
// program header size: 4*8 = 32 = 0x20
```

因为 `e_phnum = 0x3` 和 `e_phoff = 0x34 & e_phentsize = 0x20`，所以 dump 的数据如下

```shell
$ xxd -a -u -g 1 -c 16 -s 0x34 -l 0x60 2_foobar 
00000034: 01 00 00 00 00 00 00 00 00 80 04 08 00 80 04 08  ................
00000044: A0 01 00 00 A0 01 00 00 05 00 00 00 00 10 00 00  ................

00000054: 01 00 00 00 00 10 00 00 00 A0 04 08 00 A0 04 08  ................
00000064: 14 00 00 00 14 00 00 00 06 00 00 00 00 10 00 00  ................

00000074: 51 E5 74 64 00 00 00 00 00 00 00 00 00 00 00 00  Q.td............
00000084: 00 00 00 00 00 00 00 00 07 00 00 00 10 00 00 00  ................
```

|name|Program header 0|Program header 1|Program header 2|
|-|-|-|-|
|p_type  |0x01      |0x01     |0x6474E551|
|p_offset|0x0       |0x1000   |0x0|
|p_vaddr |0x08048000|0x804A000|0x0|
|p_paddr |0x08048000|0x804A000|0x0|
|p_filesz|0x1A0     |0x14     |0x0|
|p_memsz |0x1A0     |0x14     |0x0|
|p_flags |0x05      |0x06     |0x7|
|p_align |0x1000    |0x1000   |0x10|

## 参考

1. [ELF文件解析（二）：ELF header详解](https://www.cnblogs.com/jiqingwu/p/elf_explore_2.html)
2. [ELF 之 Program Loading 教學文件, #2: Program Header Table](https://www.jollen.org/blog/2007/03/elf_program_loading_2_pht.html)
3. [ELF格式文件（非常详细）](https://blog.csdn.net/weixin_44316996/article/details/107396385)
