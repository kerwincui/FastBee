# 一，conventional commit(约定式提交)
Conventional Commits 是一种用于给提交信息增加人机可读含义的规范。它提供了一组用于创建清晰的提交历史的简单规则。
## 1.1 作用
- 自动化生成 CHANGELOG
- 基于提交类型，自动决定语义化的版本变更
- 向项目相关合作开发者发送变更信心
- 触发自动化构建和部署流程
- 给开发者提供一个更加结构化的提交历史，便于减低对项目做贡献的难度
## 1.2 提交格式
提交说明的结构如下：
<type>(<scope>): <subject>
空行
[可选的正文]
空行
[可选的脚注]
### 1.2.1 Header
Header部分只有一行，包括三个字段： type（必需）、scope（必需）和subject（必需）。

#### （1）type 类型
type用于说明 commit 的类别，只允许使用下面7个标识：
- feat：新功能（feature）
- fix：修补bug
- docs：文档（documentation）
- style： 格式（不影响代码运行的变动）
- refactor：重构（即不是新增功能，也不是修改bug的代码变动）
- test：增加测试
- build：构建过程或辅助工具的变动
#### （2）scope 范围
scope用于说明 commit 影响的范围，比如指标模板、规则上下线等等，视项目不同而不同。
#### （3）subject 主题
subject是 commit 目的的简短描述，不超过50个字符。
1. 以动词开头，使用第一人称现在时，比如change，而不是changed或changes
2. 第一个字母小写
3. 结尾不加句号（.）
### 1.2.2 Body 正文
   Body 部分是对本次 commit 的详细描述，可以分成多行。
1. 需要简要的列出各种正向或者反向的测试场景，测试通过，填pass。
2. 增加修改人信息

## 1.3 例子
### 1.3.1 feat例子
```
feat(规则上下线、构建、生效、仿真生效): 添加规则上下线功能

1. 规则上下线主流程，引擎正常订阅，fldl生成正常。 pass
2. 规则上下线，传入不存在的规则编号，异常提示。 pass

提交人：xxx
```
### 1.3.2 fix例子
```
fix(模型模块): 模型测试失败

1. 导入mar模型，包含衍生字段。 pass
2. 导入mar模型，不包含衍生字段。 pass

提交人：xxx
```
## 1.4 IDEA插件推荐

1. 安装路径：File->Settings->Plugins->Marketplace->搜索Conventional Commit，点击安装即可。
2. 提交的时候点击中间的小红点创建提交消息，根据对话框提示填写相关信息即可生成规范的提交消息。

