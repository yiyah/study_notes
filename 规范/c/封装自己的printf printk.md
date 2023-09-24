
## printf

```c
#define led_drv_printf (printf("[%s](%d)\t", __FUNCTION__, __LINE__), printk)
```

## printk

```c
#define led_drv_printk(fmt, ...) printk("[%s](%d) " fmt, __FUNCTION__, __LINE__, ##__VA_ARGS__)

// 这个相当于是
printf("asdf" "ddd\n");
/** 可以这么做是因为 “两个相邻的字符串字面量会自动被合并连接为一个”
  * C语言标准所要求的，并不是某个编译器的扩展功能。
  */
```

## 参考

1. [看printk引发的一点思考](https://z.itpub.net/article/detail/D7F4374336E00AFB993D2EECC1BA0BD5) （直接看最后）
2. [封装自己的printf函数 - Maddock - 博客园 (cnblogs.com)](https://www.cnblogs.com/adong7639/p/4186779.html)
3. [__VA_ARGS__和##__VA_ARGS__的作用_侵蚀昨天的博客-CSDN博客_##x-6qa2gysoceb1ic##](https://blog.csdn.net/q2519008/article/details/80934815)
4. [BlogMarkdown/C语言中的字符串字面量连接.md at master · g199209/BlogMarkdown · GitHub](https://github.com/g199209/BlogMarkdown/blob/master/C%E8%AF%AD%E8%A8%80%E4%B8%AD%E7%9A%84%E5%AD%97%E7%AC%A6%E4%B8%B2%E5%AD%97%E9%9D%A2%E9%87%8F%E8%BF%9E%E6%8E%A5.md)