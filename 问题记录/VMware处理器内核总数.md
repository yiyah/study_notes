# VMware 怎么分配 处理器

首先就两个选项：处理器数量 和 每个处理器的内核数量

* 处理器数量 ：虚拟的CPU颗数。
* 每个处理器的内核数量：虚拟的CPU内核数。

**处理器内核总数** = 处理器数量 * 每个处理器的内核数量 （处理器内核总数 对应的是 物理CPU的线程数（逻辑处理器数量） ）

即我们只需要关注 这个 处理器内核总数 就可以了。

比如我的主机 CPU 是 i9-10850K，10核20线程

10核：10个 处理器（CPU）
20线程：每个处理器可以对应两个线程，所以是20线程。（亦即VMware的每个处理器的内核数量）

同时呢，线程 也是 逻辑处理器 的意思。（我的电脑"右键--“管理”--“设备管理器”，看到的处理器是 逻辑处理器，即线程数）

## 例子

我给 VMware 配置 2 个 CPU，每个处理器的内核数量是 6 个，即处理器内核总数是 12个。
在我主机的 20 线程范围内。

开机后，通过 `cat /proc/cpuinfo |grep processor` 可以看到 列出了 12 个 处理器

用 `make -j` 应该是这个数字

* `lscpu` 输出

    ```shell
    Architecture:        x86_64
    CPU op-mode(s):      32-bit, 64-bit
    Byte Order:          Little Endian
    CPU(s):              12             # （总）逻辑处理器的数量
    On-line CPU(s) list: 0-11
    Thread(s) per core:  1              # 每个内核的线程
    Core(s) per socket:  6              # 每个插槽上有多少个 内核
    Socket(s):           2              # 多少的插槽（我理解为 物理 CPU），看到这里应该是从下往上看
    NUMA node(s):        1
    Vendor ID:           GenuineIntel
    CPU family:          6
    Model:               165
    Model name:          Intel(R) Core(TM) i9-10850K CPU @ 3.60GHz
    Stepping:            5
    CPU MHz:             3599.998
    BogoMIPS:            7199.99
    Hypervisor vendor:   VMware
    Virtualization type: full
    L1d cache:           32K
    L1i cache:           32K
    L2 cache:            256K
    L3 cache:            20480K
    NUMA node0 CPU(s):   0-11
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon nopl xtopology tsc_reliable nonstop_tsc cpuid pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch cpuid_fault invpcid_single ssbd ibrs ibpb stibp ibrs_enhanced fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid rdseed adx smap clflushopt xsaveopt xsavec xsaves arat pku ospke flush_l1d arch_capabilities
    ```

## 参考

1. [VMWare中的处理器数量和每个处理器的内核数量概念及查询方法](https://www.huaweicloud.com/articles/f7674b45d31e97ee6a8dada409f7949c.html)（正常来说只要 处理器内核总数 < 实际主机的内核总数就行了）
2. [lscpu命令详解](https://blog.csdn.net/chenghuikai/article/details/72832016)
