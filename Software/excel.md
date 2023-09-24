# excel

## 小技巧

1. 加入很多行，如何快速复制某一个单元格的公式到最后？

   * step1: `ctrl+c` 复制这个单元格先
   * step2: 然后拉滚动条到最后，按住 `SHIFT` 的同时鼠标点最后一个单元格
   * step3: `ctrl+v` 粘贴即可

## 需求

1. A 列 和 B 列对比，找出不一样的数据

   公式 `=IF(COUNTIF($A:$A,B1),"same","diff")`
   公式解读：B1 的数据在B列中找到一样的吗？一样的话显示 same，不一样显示 diff

    示例：
    行数不一样也行
    ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20221106095145.png)

## 备注

1. `$A:$A` 的意思是引用整个A列，`$A1:$A10000` 表示引用A1单元格至A10000单元格的内容

## 参考

1. [从一列找出另一列相同的数据](https://jingyan.baidu.com/article/c35dbcb0d5c238c816fcbcf9.html) （需求1）
2. [COUNTIF 函數](https://support.microsoft.com/zh-tw/office/countif-%E5%87%BD%E6%95%B8-e0de10c6-f885-4e71-abb4-1f464816df34)（需求1）
