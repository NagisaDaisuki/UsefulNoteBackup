# Hyprland下常用指令
## Hyprland日志文件
路径`~/.cache/hypr/hyprland.log`，可以使用`tail -f ~/.cache/hypr/hyprland.log`查看日志

## journalctl 查看系统日志
`journalctl -xe`

## whoami
`whoami` `echo $USER`

## 所有用户
`cat /etc/passwd` `cut -d: -f1 /etc/passwd`

## 最近登录的用户
`last -a | head`

## 挂载U盘等外部块设备
查看所有设备:`lsblk`

(可选)创建挂载点:`sudo mkdir -p /mnt/usb`

挂载U盘等外部块设备:`sudo mount /dev/sdb1 /mnt/usb`

卸载U盘:`sudo umount /mnt/usb`

弹出U盘:`sudo eject /mnt/usb`

## 修改文件所有者为当前用户或用户组
~~~bash
sudo chown $(whoami) filename
sudo chown -R $(whoami) foldername  将文件夹及其内容的所有者改为当前用户
sudo chgrp $(id -gn) filename
sudo chgrp -R $(id -gn) foldername 
~~~

## 查看所有用户信息
```bash
id username
```

## 用户切换shell
`chsh -s /bin/bash User`需要注销后生效

## 软件包管理相关
### 查看包依赖
`pactree -r package_name`查看包的依赖关系

### 强制卸载（不考虑依赖）
`sudo pacman -Rdd package_name`

### 使用软链替代
`sudo ln -sf /bin/bash /usr/bin/fish`

`sudo ln -sf /usr/bin/vi /usr/bin/vim`

## ✨ fc-list 查看所有已安装字体
> fc-list | grep "Nerd" 可以用来查找支持图标扩展的字体
>
> fc-list | grep -i "font name" 筛选字体

## 👀 设置置Wayland环境下的GTK、QT、终端、Waybar等组件的字体
### 1. 设置GTK字体
- 对于GTK3：
```bash
vim ~/.config/gtk-3.0/settings.ini
```
- 对于GTK4：
```bash
vim ~/.config/gtk-4.0/settings.ini
```
添加或者修改以下内容:
```bash
[Settings]
gtk-font-name = JetBrains Mono Nerd Font 12
```
### 2. 设置Qt应用字体
- 如果你使用的是Qt5ct/Qt6ct：
```
sudo pacman -S qt5ct qt6ct
```
- 设置环境变量：
```
echo 'export QT_QPA_PLATFORMTHEME=qt5ct' >> ~/.profile
```
重新登陆或重启Hyprland

然后运行：
```bash
qt5ct
qt6ct
```

在其中选择字体，比如 `JetBrains Mono Nerd Font`

### 3. Waybar字体设置
编辑配置：
```bash
~/.config/waybar/config
~/.config/waybar/style.css
```
在style.css设置字体：
```bash
* {
  font-family: "JetBrains Mono Nerd Font";
  font-size: 12px;

}
```
### 4. Terminal字体设置
在各自的终端配置文件中设置
### 5. 设置全局字体环境变量
在`~/.profile`或`~/.config/environment`中添加以下内容：
~~~bash
echo 'XDG_CURRENT_DESKTOP=Hyprland' >> ~/.profile
echo 'GDK_SCALE=1' >> ~/.profile
echo 'GTK_THEME=Adwaita:dark' >> ~/.profile
echo 'QT_QPA_PLATFORMTHEME=qt5ct' >> ~/.profile
~~~
### 6. 重启生效
### extra. 设置fallback字体(避免方块、乱码)
安装
~~~bash
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji
~~~
这样能确保你的主字体没覆盖到的字符由Noto系列补上
## 🥹 创建systemd定时任务
### 📁 文件结构
1. 服务文件（.service）：定义要执行的操作
`/etc/systemd/system/backup.service`

> 用户定时服务`/etc/systemd/user/backup.service`
2. 定时器文件（.timer）：定义何时执行
`/etc/systemd/system/backup.timer`

> 用户定时器`/etc/systemd/user/backup.timer`
## 🫩 查看systmed timer定时任务 
### 系统定时任务
```bash
systemctl list-timers
```
### 用户定时任务
```bash
systemctl --user list-timers 
```

## 使用fish创建alias
- 在fish文件夹`~/.config/fish/config.fish`中创建函数
~~~bash
vim config.fish
alias shgo="sh"

function runsh
  sh ~/myscript.sh
end
~~~
使用source命令使其立即生效
`source ~/.config/fish/config.fish`

- 将function单独保存
直接使用funcsave命令保存函数
```bash
funcsave runsh
```
这样会自动把`runsh`保存到`~/.config/fish/functions/runsh.fish`中了:
