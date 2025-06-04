让 CMD 和 PowerShell 永久使用 UTF-8 编码，能解决大量中文乱码、字符错乱、复制粘贴错误等问题，特别适合你用 Vim、Python、Git、Node 等工具时用中文不出错。
# ✅ 一键理解：默认编码页是什么？
### Windows控制台（CMD/PowerShell）默认编码页面是：
- CMD-->`CP936`(简体中文GBK)
- PowerShell-->取决于版本和系统，也可能是`GBK`
我们想让它变成:
- ✅ `UTF-8`-->代码页号是65001
# 😭~~方法一：修改注册表（永久改变 CMD 和 PowerShell 的默认编码页）~~
### ① 打开注册表编辑器（Win + R）输入：
~~~
regedit
~~~
### ② 找到以下路径：
~~~
HKEY_CURRENT_USER\Console
~~~
### ③ 修改或添加 DWORD 值：
- 名称：`CodePage`
- 类型：`REG_DWORD`
- 数值：`65001`（十进制）或`0x0000fde9`（十六进制）
### 🧠 这个设置会让所有基于 Console 的窗口（CMD、PowerShell、Vim、bat 脚本）默认使用 UTF-8 编码页
# ✅ 效果验证
重启cmd或PowerShell：
~~~
chcp
~~~
如果输出：
~~~
Active code page: 65001
~~~
说明设置成功！
# ✅ 方法二：只修改当前 CMD 快捷方式默认编码
```
chcp 65001
```
# 😪 ~~方法三（PowerShell 专用）：配置 profile 文件在PowerShell中创建或编辑启动脚本：~~
~~~
notepad $PROFILE
~~~
添加这两行：
~~~
[console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$OutputEncoding = [System.Text.UTF8Encoding]::new()
~~~ 
# ✅ 方法四：修改wt的settings.json
```
{
  "name": "Command Prompt",
  "commandline": "cmd.exe /k chcp 65001",
  "startingDirectory": "%USERPROFILE%",
  "hidden": false
}
```