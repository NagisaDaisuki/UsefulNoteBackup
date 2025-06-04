# 📕 Zypper包管理器命令
## 📦 基础操作
### 更新软件源和系统
```
sudo zypper refresh
sudo zypper uadate
```
### 安装软件
```
sudo zypper install 包名
sudo zypper install git
```
### 删除软件
```
sudo zypper remove 包名
```
### 查找软件包
```
zypper search 关键字
zypper search firefox
```
## 🧰 软件源（仓库）管理
### 查看当前软件源列表
```
zypper repos
```
### 添加一个新源
```
sudo zypper addrepo URL 名称
示例：
sudo zypper addrepo https://download.opensuse.org/repositories/graphics/openSUSE_Tumbleweed/ graphics
```
### 删除软件源
```
sudo zypper removerepo 名称或编号
```

## 🔧 软件包管理进阶
### 查看某个包的信息
```
zypper info 包名
```
### 锁定某个包(禁止更新)
```
sudo zypper addlock 包名
```
### 解除锁定
```
sudo zypper removelock 包名
```
## 📁 本地 RPM 包操作
### 安装本地RPM包
```
sudo zypper install ./package.rpm 
```
## 🧹 清理
```
sudo zypper clean   # 清理缓存
sudo zypper clean --all     # 更彻底地清理
```
## 🆘 获取帮助
```
zypper help     # 显示帮助菜单
zypper help 命令名  # 查看某个命令的帮助
```
<br><br>

# 🖥️ 系统信息与资源查看

|操作|命令|
|:---:|:---:|
|查看系统版本|`cat /etc/os-release`|
|查看内核版本|`uname -r`|
|查看CPU信息|`lscpu`|
|查看内存使用情况|`free -h`|
|查看磁盘使用情况|`df -h`|
|查看系统运行时间|`uptime`|
