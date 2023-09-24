



# VC++6.0如何取消注

使用以下脚本代码！来自参考2！

```
    '------------------------------------------------------------------------------  
    'FILE DESCRIPTION: 为开发环境添加批量注释或取消注释  
    '------------------------------------------------------------------------------  
    Sub SetSelNote()'Sun DESCRIPTION:过程SetSelNote用于将选中的文本转换为注释  
        dim CurWin'当前获得的窗口  
        set CurWin = ActiveWindow  
      
        if CurWin.type<>"Text" Then'判断当前窗口是否是文本窗口  
            MsgBox "当前窗口不是文本窗口"  
        else  
            NoteType = "//"  
      
            BeginLine = ActiveDocument.Selection.TopLine  
            EndLine   = ActiveDocument.Selection.BottomLine  
      
            if EndLine<BeginLine then  
                Line = BeginLine  
                BeginLine = EndLine  
                EndLine = Line  
            else  
                for row = BeginLine To EndLine  
                    ActiveDocument.Selection.GoToLine row  
                    ActiveDocument.Selection.SelectLine'选中当前行  
                    ActiveDocument.Selection = NoteType+ActiveDocument.Selection  
                Next  
            End if  
        End if  
    End Sub  
      
    Sub CancelSelNote()  
        dim CurWin'当前获得的窗口  
        set CurWin = ActiveWindow  
      
        if CurWin.type<>"Text" Then'判断当前窗口是否是文本窗口  
            MsgBox "当前窗口不是代码窗口"  
        else  
      
            BeginLine = ActiveDocument.Selection.TopLine  
            EndLine   = ActiveDocument.Selection.BottomLine  
      
            if EndLine<BeginLine then  
                Line = BeginLine  
                BeginLine = EndLine  
                EndLine = Line  
            else  
                for row = BeginLine To EndLine  
                    ActiveDocument.Selection.GoToLine row  
                    ActiveDocument.Selection.SelectLine'选中当前行  
                    SelBlock = ActiveDocument.Selection  
      
                    Trim(SelBlock)  
                    pos = instr(SelBlock, "//")  
                    if pos<>0 then  
                        RightBlock = Right(SelBlock,Len(SelBlock)-2)  
                        ActiveDocument.Selection = RightBlock  
                    End if  
                Next  
            End if  
        End if  
    End Sub  
```



## 参考

1.  [VC++6.0注释快捷键设置](https://blog.csdn.net/gzshun/article/details/7782458)

2.  [VC++6.0中添加批量注释和取消批量注释快捷键](https://blog.csdn.net/qq_21808961/article/details/78191001?depth_1-utm_source=distribute.pc_relevant.none-task&utm_source=distribute.pc_relevant.none-task)

