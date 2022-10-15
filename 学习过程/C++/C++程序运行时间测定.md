# C++程序运行时间测定

---


```c++
#include <iostream>
#include <time.h>
usingnamespace std;

int main()
{
    clock_t start = clock();
    // Place your codes here...
    clock_t ends = clock();
    cout <<"Running Time : "<<(double)(ends - start)/ CLOCKS_PER_SEC << endl;
    return 0;
}
```


## 参考
1. [C++程序运行时间测定](https://www.cnblogs.com/killerlegend/p/3877703.html)
