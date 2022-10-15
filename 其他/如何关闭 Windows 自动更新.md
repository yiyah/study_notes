# 如何关闭 Windows 自动更新

1.  <win + R> 打开 services.msc 
    *   找到 Windows update ---> 常规选项 ---> 启动类型：禁用 ---> 服务状态：停止
    *   恢复选项 ---> 第一次失败 ---> 无操作
    *   确定

2.  <win + R> 打开 gpedit.msc
    *   计算机配置 ---> 管理模板 ---> Windows 组件 ---> Windows update ---> 双击 “配置自动更新” ---> 禁用 ---> 确定