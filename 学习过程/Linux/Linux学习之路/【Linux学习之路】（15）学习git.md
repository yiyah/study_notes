# 学习 git

---

[TOC]

## 一、安装git

```shell
sudo apt-get install git
git --version # 查看版本
```

## 二、配置参数

```shell
git config --global user.name "your name"
git config --global user.email "your email"
# Like
git config --global user.name "yiyah"
git config --global user.email "756307810@qq.com"

git config --global core.editor vim  // 修改 git 的默认编辑器

# --global配置对当前用户生效，如果需要对所有用户生效，则用--system
git config --list user.name // 查看配置
```

## 三、绑定你的电脑和 Git 账号

原理：通过 ssh key 。

* 为什么GitHub需要SSH Key呢？
    因为GitHub需要识别出你推送的提交确实是你推送的，而不是别人冒充的，而Git支持SSH协议，所以，GitHub只要知道了你的公钥，就可以确认只有你自己才能推送。
    当然，GitHub允许你添加多个Key。假定你有若干电脑，你一会儿在公司提交，一会儿在家里提交，只要把每台电脑的Key都添加到GitHub，就可以在每台电脑上往GitHub推送了。

### 3.1 step1: 创建 SSHKey

先到用户的主目录看看有没有.ssh目录，如果有，再看看这个目录下有没有`id_rsa`和`id_rsa.pub`这两个文件，如果已经有了，可直接跳到下一步。如果没有，输入以下命令（输入后默认回车就好了）。

注意：用户主目录是指`cd ~/.ssh`

```shell
ssh-keygen -t rsa -C "youremail@example.com"
# 执行后就会在 ~/下生成 .ssh 目录
# 如果显示已经存在了，需要删除重新生成。
```

### 3.2 step2：添加公钥到 github

```shell
1. 登陆github，打开“Account settings”，“SSH Keys”页面：
2. 然后，点“Add SSH Key”，填上任意Title，在Key文本框里粘贴 id_rsa.pub 文件的内容（看看最后是不是你的邮箱，不是的话需要重新生成，重新生成需要删掉旧的）
3. 点“Add Key”，你就应该看到已经添加的Key：
```

这样就已经把你的github和电脑绑定在一起了。

## 四、git 的使用

### 4.1 git init

把本地目录变成 Git 可以管理的仓库

```shell
cd your catalog
git init
# 你的目录会多了一个 .git的目录，这个目录是Git来跟踪管理版本库的，没事千万不要手动修改这个目录里面的文件，不然改乱了，就把Git仓库给破坏了。
```

### 4.2 git add \<file> 和 git commit -m \<message>

把一个文件放到 git 仓库的两个步骤：（交给Git管理之后，该文件的任何改动都会被记录下来）

```shell
# step1:用命令 git add 告诉 Git，把文件添加到仓库：
git add readme.txt
# step2: 用命令 git commit告诉Git，把文件提交到仓库：
git commit -m "wrote a readme file" # -m后面输入的是本次提交的说明，可以输入任意内容，当然最好是有意义的，这样你就能从历史记录里方便地找到改动记录。
```

### 4.3 git status 和 git diff

```shell
git status # 该命令可以让我们时刻掌握仓库当前的状态
git diff xxx.txt # 该命令可以让我们知道哪里修改了
```

### 4.4 版本回退和恢复

```shell
# HEAD指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令
git reset --hard commit_id
git log # 可以查看提交历史，以便确定要回退到哪个版本。穿梭前，用git log
git reflog # 查看命令历史。要重返未来，以便确定要回到未来的哪个版本。

git reset --hard HEAD^ # ^回到上一个版本，上上一个版本就是HEAD^^，可以写成HEAD~2。
```

### 4.5 clone 操作

当我们想要从 github 上面拉取代码时，就需要使用 clone 操作，现在我们看看怎么进行 clone，

其实很简单，只需要输入 git clone<需要 clone 的地址>，示例如下：

```shell
git clone git@github.com:yiyah/learngit.git
# git clone git@github.com:github账户名/仓库名.git
# 有的时候我们需要拉取依赖库，就需要加上--recursive 选项。
```

### 4.6 push 操作

想要把本地仓库的内容 push 到远程仓库必须满足以下条件：

1. 该文件被 git 管理
2. 将本地仓库和远程仓库联系起来，使用如下命令（不知道这样理解对不对）

```shell
# 方法一(使用Http协议):（这个会导致每次push都要账号密码）
git remote add origin https://github.com/yiyah/git.git
# 方法二(使用ssh协议)：（推荐这个）
git remote add origin git@github.com:yiyah/git.git # git.git 改成你的 仓库名.git
# remote：遥远的
# origin：指向远程 repository 的地址
```

push 操作(会把被git 管理的文件都push到你的github上)

```shell
# 第一次 push（参考5）
git push -u origin master
# 以后
git push origin master # 如果回退后在上传到远程仓库会提示 远程的有个更新的版本。上传不了，此时可以 在 push 后加 -f，强制更新。
```

### 4.7 删除远程仓库的 文件/文件夹

* 其实不用像下面这么麻烦，只要本地删除了，然后 `add` `commit` `push` 就可以了。

```shell
# 1. 预览将要删除的文件
git rm -r -n --cached 文件/文件夹名称 # 加上 -n 这个参数，执行命令时，是不会删除任何文件，而是展示此命令要删除的文件列表预览。
# 2. 确定无误后删除文件
git rm -r --cached 文件/文件夹名称
# 3. 提交到本地并推送到远程服务器
git commit -m "提交说明"
git push origin master
```

* 删除远程分支：本地删除了 --> `git push origin -d branchName`

### 4.8 远程仓库更新到本地

* `git fetch` 的使用

    ```shell
    # 方法一：
    git fetch origin master  # 从远程的origin仓库的master分支下载代码到本地的origin master
    git log -p master.. origin/master  # 比较本地的仓库和远程仓库的区别
    git merge origin/master  # 把远程下载下来的代码合并到本地仓库，远程的和本地的合并

    # 方法二：
    git fetch origin master:temp  # 从远程的origin仓库的master分支下载到本地并新建一个分支temp
    git diff temp  # 比较master分支和temp分支的不同
    git merge temp  # 合并temp分支到master分支
    git branch -d temp  # 删除temp
    ```

* `git pull` 的使用

    ```shell
    git pull origin master
    ```

* 总结（`fetch` 和 `pull` 的区别）

    1. `git fetch` 相当于是从远程获取最新版本到本地，不会自动 merge。
    2. `git pull` 相当于是从远程获取最新版本并 merge 到本地。
    3. 实际使用中，git fetch更安全一些
        因为在merge前，我们可以查看更新情况，然后再决定是否合并。

### 4.9 已经 push 的 commit 如何修改 change (非 commit 信息)

即现在这个 commit 已经 push 了，但是现在想修改这个 commit 的某个文件

* step1: git rebase -i HEAD~n   # -i 表示交互，n 表示往上 n 条记录
* step2: 在需要修改的 commit ID 前把 pick 改为 e
* step3: 修改文件
* step4: git add xxx
* step5: git commit --amend
* step6: git rebase --continue
* step7: git push xxx

### 4.10 未 add 的文件如何恢复原来的状态？

即现在修改了多个文件，但不想要某个文件的修改了，怎么办？

* step1: git log 查看最近的 commit ID
* step2: git checkout ID xxx_file

经实验，如果有两个未 add 的文件，使用该方法是 恢复指定的文件，另一文件不受影响

`git checkout .` 会把当前目录未 add 的都恢复

### 4.11 git 打 patch

Git 提供了两种补丁方案：

* 一是用 `git diff` 生成的 UNIX 标准补丁 `.diff` 文件
  `.diff` 文件只是记录文件改变的内容，不带有 commit 记录信息,多个 commit 可以合并成一个 diff 文件。
* 二是 `git format-patch` 生成的 Git 专用 `.patch` 文件。
  `.patch` 文件带有记录文件改变的内容，也带有 commit 记录信息,每个 commit 对应一个 patch 文件。

* 打 patch

    ```shell
    git am 【path/to/xxx.patch】
    git apply 【path/to/xxx.patch】
    git apply 【path/to/xxx.diff】
    ```

* 生成 patch

    ```shell
    # 1. 本地 未add 的文件
    # ====================
    git diff >> xxx.diff

    # 2. 本地 已提交 的
    # ====================
    # 某次提交（含）之前的几次提交
    git format-patch 【commit sha1 id】-n   # n 是前几次，1 的话就是本 commit

    # 某两次提交之间的所有 patch
    git format-patch 【commit sha1 id】..【commit sha1 id】 
    ```

    ```shell
    # 生成 本次 未更改的 patch

    ```

### 4.12 对比本地和远程分支 的区别

```shell
# step1: 更新本地的远程分支
git fetch origin master     # 该命令只是更新 commit 信息，并不会合并

# step2: 本地与远程的差集 :（显示远程有而本地没有的commit信息）
git log master..origin/master
```

## git log 和 git blame

```bash
git log -p xxx.c    # 可以查看 log 的同时看修改了哪些变化，主要是可以直接搜索被改的那条语句的 commit
git blame xxx.c     # 查看某个文件的每一行的 最后一次 修改是谁
```

## commit 和 issue 模板

* commit

    ```shell
    # 查看
    git config commit.template # 查看当前仓库 该变量的值

    # 修改
    git config commit.template xxx.template # 只对当前仓库有空
    git config --global commit.template xxx.template # 全局
    ```

* issue

    ```shell

    ```

## 五、问题

1. `git remote add origin git@github.com:yiyah/learngit.git` 里的 origin 怎么理解？

    origin 看成是 git@github.com:yiyah/learngit.git 的别名。
    所以 `git push origin master` 就是指：push 到 origin 的 master 分支。

2. git clone 的时候提示以下错误

    ```shell
    $ git clone git@github.com:yiyah/GitGitGit.git
    Cloning into 'GitGitGit'...
    The authenticity of host 'github.com (13.250.177.223)' can't be     established.
    RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
    Are you sure you want to continue connecting (yes/no)?
    Host key verification failed.
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
    # 解决方法（参考2）：Are you sure you want to continue connecting (yes/no)?     这里输入yes
    ```

3. git push 的时候每次都要账号密码

    * 原因：这是因为添加远程仓库的时候使用了 http 协议：

        `git remote add origin https://github.com/yiyah/git.git`

    ```shell
    # 解决方法（参考3）：
    # 1. 查看git clone方式，如果是 origin https://github.com......开头就说明需要调整
    git remote -v
    git config --get remote.origin.url # 或者这个也可以查看
    # 2. 移除原来的git源
    git remote rm origin
    # 3. 添加新的git源头（地址修改为要调整的）
    git remote add origin git@github.com:yiyah/git.git
    # 4. 再查看git方式，如果是origin git@github.com....就开头就说明OK了，重新push就不用每次都输入账号密码了

    # way2
    # 或者直接这样也可以改变 git 源头
    git remote set-url origin git@github.com:yiyah/git.git
    ```

4. 怎么上传大文件？

    参考 6 的 使用 git LFS
    安装好 git LFS 后，`cd` 到要上传的文件夹

    ```shell
    git lfs install
    git lfs track *.zip # 跟踪要上传的文件
    # 然后正常 push 就可以了
    ```

5. git 下载慢

    * 前提：有梯子
    * 解决方法（小飞机为例）：找到本地的代理端口（右键小飞机 --> 选项设置 --> 记住 本地代理 下的本地端口）

        * 自己总结

            ```shell
            git config --global http.proxy http://127.0.0.1:12333
            # 或者
            git config --global http.proxy socks5://127.0.0.1:1080

            # 取消
            git config --global --unset http.proxy
            ```

        * 别人的

            ```shell
            git config --global http.https://github.com.proxy   socks5://127.0.0.1:1080   # 把1080改成自己的
            git config --global https.https://github.com.proxy  socks5://127.0.0.1:1080  # 把1080改成自己的
            # 下面两条命令和上两条不一样的是：上两条只针对 github，详情看参考   8、9.
            git config --global http.proxy socks5://127.0.0.1:1080      # 把1080改成自己的
            git config --global https.proxy socks5://127.0.0.1:1080     # 把1080改成自己的

            # 取消代理命令
            git config -l # 查看所有配置
            git config --global --unset http.https://github.com.proxy
            git config --global --unset https.https://github.com.   proxy
            ```

        * 其他方法：
            * 说明：在尝试了以上的代理设置方法后，下载速度还是很慢的话，可以试一下以下的设置（参考11）。因为我就是设置了代理，但还是很慢！尝试以下后很快!

            ```shell
            # step1
            git config --global http.proxy socks://127.0.0.1:1080
            git config --global https.proxy socks://127.0.0.1:1080
            # step2：（关键！不过好像不用第一步都行）
            vim ~/.ssh/config
            ProxyCommand nc -x localhost:1080 %h %p  # 添加、保存、退出
            # step3：验证
            git clone git@github.com:ArduPilot/ardupilot.git
            ```

6. 出现错误 fatal: The remote end hung up unexpectedly

    * 产生原因：我在 build ardupilot 源码的时候，执行 `git submodule update --init --recursive`，出现此问题。
    * 问题原因：推送的文件太大。
    * 解决方法：

        ```shell
        # step1: 修改设置git config文件的postBuffer的大小。（设置为500MB）--local选项指定这个设置只对当前仓库生效。
        git config --local http.postBuffer 524288000
        # step2（step1 不行再搞这个）: 增加最低速度时间
        git config --local http.lowSpeedLimit 0
        git config --local http.lowSpeedTime 999999
        ```

7. 如何修改 已经提交的 commit message

    ```bash
    # 修改上一条 commit
    git commit --amend

    # step1: 修改 前几条
    git rebase -i HEAD~2

    # step2: 把 pick 改为 r 或者 edit，保存退出
    # step3: git commit --amend
    # step4: git rebase --continue
    
    # 如果你的修改只是针对本地，那么正常用 git push 就好了
    # 但如果是修改 远程仓库的 commit message，就需要 git push -f
    # 网上说不要推送到 公共仓库，因为已经改变了 commit id，但是自己的就不要紧
    ```

8. 经常遇到的一个问题

   就是我 push 到 origin 后，过后我才发现 commit message 有误，想要修改。但是此时 local 已经有其他修改了，并且没有 `git commit`。这个时候用 `git rebase` 的话，会提示要先保存修改。但是测试修改还没完成。怎么办？

   目前是：要吗先把修改 导出 成 patch 文件，然后 `git checkout` 再 `git rebase`，在打 patch。
   但是这种未免有点麻烦，应该可以通过分支来解决。

## 总结

1. 新电脑配置。
    step1: 每个机器都必须自报家门

    ```shell
    git config --global user.name "yiyah"
    git config --global user.email "756307810@qq.com"
    ```

    step2: 初始化一个仓库 `git init`
    step3: 添加文件并提交让 git 管理 `git add xxx` `git commit -m "xxx"`
    step4: 建立远程仓库（需要生成 rsa，把公钥放到 github 上）

    ```shell
    ssh-keygen -t rsa -C "756307810@qq.com" # cat ~/.id_rsa.pub 其实不用 email 也可以
    ```

    step5：关联 本地仓库 与 远程仓库

    ```shell
    git remote add origin git@github.com:yiyah/learngit.git # learngit.git 换成你的仓库名字
    ```

    step6: push

    ```shell
    git push -u origin master # 第一次提交，-u 是指定默认主机 origin
    git push origin master # 以后提交
    // 想想在公司是 git push mediatek.dtv HEAD:refs/for/branchName
    // 所以，origin 是远程仓库的地址，因为在上一步相当于给它起了个名字
    ```

    step7: clone

    ```shell
    git clone git@github.com:yiyah/learngit.git # learngit.git 换成自己的仓库名字
    ```

2. 只要 `git commit --amend` 无论修不修改，commit ID 都会变
3. `git diff` 比较的是 工作区和暂存区的文件，因为 add 后，diff 就没有区别了

## 六、参考

1. [远程仓库](https://www.liaoxuefeng.com/wiki/896043488029600/896954117292416)
2. [Git diff (---和+++具体解释)](https://www.cnblogs.com/lovezbs/p/4558982.html)
3. [The authenticity of host 'github.com (13.250.177.223)' can't be established.](https://blog.csdn.net/taoerchun/article/details/94349910)
4. [github每次push提交都要输入账号密码](https://blog.csdn.net/JackLiu16/article/details/80465982)
5. [Git 里面的 origin 到底代表啥意思?](https://blog.csdn.net/yexudengzhidao/article/details/102882774)
6. [远程仓库$ git remote add origin https://github.com/wu347771769/learngit.git](https://blog.csdn.net/wu347771769/article/details/88999943)
7. [突破github的100M单个大文件上传限制](https://blog.csdn.net/tyro_java/article/details/53440666)
8. [git 删除远程仓库文件](https://www.jianshu.com/p/de75a9e3d1e1)
9. [一招 git clone 加速](https://juejin.im/post/5cfe66406fb9a07edb393c56)
10. [一招 git clone 加速 【实测有效】](https://www.cnblogs.com/yizhixue-hx/p/12817353.html)
11. [git 设置和取消代理](https://gist.github.com/laispace/666dd7b27e9116faece6)
12. [github 代理设置 https/git 速度直接从14k/s 飙升 5m+/s](https://segmentfault.com/a/1190000018813121)（有用！）
13. [Git：解决报错：fatal: The remote end hung up unexpectedly](https://blog.csdn.net/u013250071/article/details/81203900)
14. [解决Git 克隆代码 The remote end hung up unexpectedly错误](https://www.jianshu.com/p/5f2348927504)
15. [Git更新代码到本地](https://blog.csdn.net/y532798113/article/details/82899933?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase)
16. [Git fetch和git pull的区别](https://blog.csdn.net/hudashi/article/details/7664457)
17. [git push origin与git push -u origin master的区别](https://blog.csdn.net/qq_15899635/article/details/88421585)（-u 参数的意义）
18. [Git 里面的 origin 到底代表啥意思?](https://www.zhihu.com/question/27712995/answer/660393268)
19. [rebase](http://gitbook.liuhui998.com/4_2.html)
20. [Git 修改已提交的commit注释](https://www.jianshu.com/p/098d85a58bf1)
21. [如何在github上添加自定义的issue template](https://www.jianshu.com/p/2cb8f94a7f2c?utm_campaign=shakespeare&utm_content=note&utm_medium=seo_notes&utm_source=recommendation)
22. [Git 打补丁-- patch 和 diff 的使用（详细）](https://www.jianshu.com/p/ec04de3f95cc)
