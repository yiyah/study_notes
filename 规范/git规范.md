# git 规范

## 版本号

版本格式

主版本号.次版本号.修订号，版本号递增规则如下：

* 主版本号(major)：当你做了不兼容的 API 修改，
* 次版本号(minor)：当你做了向下兼容的功能性新增，可以理解为Feature版本，
* 修订号(patch)：当你做了向下兼容的问题修正，可以理解为Bug fix版本。

先行版本号可以加到“主版本号.次版本号.修订号”的后面，作为延伸。

先行版本
当即将发布大版本改动前，但是又不能保证这个版本的功能 100% 正常，这个时候可以发布先行版本：

* alpha: 内部版本
* beta: 公测版本
* rc: 候选版本(Release candiate)

* feat: 次版本(minor)+1
* fix: 修订号(patch) +1
* BREAK CHANGE: 主板号(marjor) +1

## 提交规范

* `git log --pretty="%s (%cr)"` 用这条命令看提交历史，格式化输出

```git
:bug: Fix: Fix memory issue

[Description]
xxx

# 关于 emoji，格式最好是 Fix: :pencil: Fix xxx
# 也可以是 :pencil: Fix: Fix xxx
# 区别是 emoji 的位置了，第一种方便 git log 查看记录
```

1. 主要

   * feat：增加一个新功能 :sparkles: （引入新功能）
   * fix：修复bug :bug:
   * add: 初次提交 :tada:

2. 特殊

   * docs：:pencil: 只修改了文档，比如 README, CHANGELOG, CONTRIBUTE 等等
   * style：:pencil2:（代码）不改变代码逻辑，做了不影响代码含义的修改，空格、格式化等等
   * refactor：（代码 :art:）代码重构，既不是修复bug，也不是新功能的修改。（重命名，换路径，可能是换个变量名之类的, 移除测试代码中无用的引用）
   * revert：回滚到上一个版本

3. 暂不用

   * perf：（代码）优化相关，如提升性能、体验等 :lipstick:
   * test：增加测试或更新已有的测试 :white_check_mark: （增加测试）
   * chore：不修改src或者test的其余修改，例如构建过程或辅助工具的变动（构建或辅助工具或依赖库的更新）
   * merge：代码合并
   * sync：同步主线或分支的Bug

## 修改 git 默认的 commit 模板

```git
# 如果不要 --global 则仅对当前项目有效
git config --global commit.template ~/xxx
```

## issue 模板

在 github 上添加自定义的 issue template

* step1: 在项目下，`mkdir .github`
* step2: 把 模板.md 放到里面提交并 push 就可以了

```markdown
<!--
Q1: Describe the issue
-->

⚠️⚠️ REPLACE WITH DESCRIPTION

<!--
Q2: Describe the steps to reproduce, like below
* step1: xxx
* step2: xxx
* ....
-->

<details>
<summary><code>Steps to reproduce</code></summary>

* step1: ⚠️⚠️ REPLACE WITH STEP

</details>

<!--
Q3: Provide your OS name and version
-->

**OS:** ⚠️⚠️ REPLACE WITH OS VERSION

```

🎨 (调色板)    :art:                   改进代码结构/代码格式
⚡️ (闪电)      :zap:                   提升性能
🐎 (赛马)      :racehorse:             提升性能
🔥 (火焰)      :fire:                  移除代码或文件
🐛 (bug)       :bug:                   修复 bug
🚑 (急救车)    :ambulance:             重要补丁
✨ (火花)      :sparkles:              引入新功能  Feat
📝 (铅笔)      :pencil:                撰写文档
🚀 (火箭)      :rocket:                部署功能
💄 (口红)      :lipstick:              更新 UI 和样式文件
🎉 (庆祝)      :tada:                  初次提交
✅ (白色复选框) :white_check_mark:    增加测试
🔒 (锁)        :lock:                  修复安全问题
🍎 (苹果)      :apple:                 修复 macOS 下的问题
🐧 (企鹅)      :penguin:               修复 Linux 下的问题
🏁 (旗帜)      :checked_flag:          修复 Windows 下的问题
🔖 (书签)      :bookmark:              发行/版本标签
🚨 (警车灯)    :rotating_light:         移除 linter警告
🚧 (施工)      :construction:          工作进行中
💚 (绿心)      :green_heart:           修复 CI 构建问题
⬇️ (下降箭头)   :arrow_down:            降级依赖
⬆️ (上升箭头)   :arrow_up:              升级依赖
👷 (工人)       :construction_worker:    添加 CI 构建系统
📈 (上升趋势图) :chart_with_upwards_trend:    添加分析或跟踪代码
🔨 (锤子)      :hammer:                重大重构
➖ (减号)      :heavy_minus_sign:      减少一个依赖
🐳 (鲸鱼)      :whale:                 Docker 相关工作
➕ (加号)      :heavy_plus_sign:       增加一个依赖
🔧 (扳手)      :wrench:                修改配置文件
🌐 (地球)      :globe_with_meridians:  国际化与本地化
✏️ (铅笔)      :pencil2:               修复 typo

## 参考

1. [规范GIT代码提交信息&自动化版本管理](https://jelly.jd.com/article/5f51aa34da524a0147e9529d)
2. [Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
3. [2.3 Git 基础 - 查看提交历史](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E6%9F%A5%E7%9C%8B%E6%8F%90%E4%BA%A4%E5%8E%86%E5%8F%B2)
4. [d2-projects/d2-admin](https://github.com/d2-projects/d2-admin/commits/master)（参考别人的项目的 提交信息）
5. [Git commit 规范以及 emoji 列表](https://www.jianshu.com/p/dbc1c27acad2?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation)
6. [如何在github上添加自定义的issue template](https://www.jianshu.com/p/2cb8f94a7f2c?utm_campaign=shakespeare&utm_content=note&utm_medium=seo_notes&utm_source=recommendation)
