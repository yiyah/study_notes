# color line

作个注释

```cmd
@echo off

rem add "" if have space
call :set_color " s" 0a     # 最后不能是空格，因为是创建文件的方式
pause > nul


:set_color
set /p= <nul >%1           # 这个等号后面的符号是 退格符，用来删掉 findstr 的输出:，然后再退格，以便于下一个输出
findstr /a:%2  %1*        # 在 %1 中查找 ，找到就输出该文件，一般就是 %1 即传进来要显示颜色的字符串
del %1
goto :eof                   # 也可用 exit /b
```
