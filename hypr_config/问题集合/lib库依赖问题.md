### 问题： requires libstdc++.so.6(GLIBCXX_3.4.21)(64bit)
<br>

#### 问题描述：系统缺少'libstdc++.so.6'这个库的特定版本符号'GLIBCXX_3.4.21'，这是标准c++库的一部分。
<br>

#### 解决问题步骤:

- ##### 1. 检查现有版本
首先检查系统上现有的'libstdc++'版本：
```
strings /usr/lib64/libstdc++.so.6 | grep GLIBCXX
```
如果没有找到'GLIBCXX_3.4.21', 需要更新或安装一个新的版本
- ##### 2. 更新'libstdc++'
根据具体操作系统的包管理器进行更新
```
Centos: sudo yum update libstdc++
ArchLinux: 
```
如果系统已经是最新的，那么需要从源代码编译或者安装更新的GCC版本
- ##### 3. 从源代码编译新版本的GCC
如果官方仓库中没有更新版本的'libstdc++'，可以选择编译一个新的GCC版本
    1. 下载解压GCC源代码
    2. 安装编译依赖
    3. 配置和编译gcc
    4. 安装新版本的gcc
编译完成后，新的'libstdc++'库应该包含所需的'GLIBCXX_3.4.21'符号
<br>

#### 验证
再次运行以下命令，确保新安装的'libstdc++'包含所需的符号：
```
strings /usr/local/lib64/libstdc++.so.6 | grep GLIBCXX_3.4.21
``` 
