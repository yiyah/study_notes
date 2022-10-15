# str与bytes之间的转换

```python3
# bytes object
b = b"example"

# str object
s = "example"

# str to bytes
bytes(s, encoding = "utf8")

# bytes to str
str(b, encoding = "utf-8")

# an alternative method
# str to bytes
str.encode(s)

# bytes to str
bytes.decode(b)
```

## 参考

1. [python str与bytes之间的转换](https://blog.csdn.net/yatere/article/details/6606316)
