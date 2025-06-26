## hyprland 全安装指北
- 需要一个archlinux启动盘 ---> 在**windows**上使用u盘制作工具实现
- 安装archlinux教程 ---> [archlinux简明指南](arch.icekylin.online)
- 安装hyprland in archlinux ---> [hyprland](hyprland.org) [archlinux](wiki.archlinux.org/title/Hyprland)
- 或者选择美化一键安装hyprland ---> [ends_4's hyprland](github.com/end-4/dots-hyprland/tree/main?tab=readme-ov-file)
> 在这之前需要有一个非常好的网络环境，所以clash启动(
>> 1.在我的u盘上找到clash-for-linux的压缩包,然后解压并放到合适的位置等待启动      <br />
>> 2.在运行clash之前最好整一个daemon实现每次进入系统就启动clash,                <br />
>> 所以一个service文件需要在`/etc/systemd/system`文件夹下创建                 <br />
>> [`touch /etc/systemd/system/clash.service`](#clash_service) <br />
>> 3.配置启动需要的三个文件`cache.db`,`config.yaml`,`Country.mmdb`,这些文件都存放在用户的配置目录下: `mkdir ~/.config/clash && mv 这三个文件 ~/.config/clash` <br />
>> **tips**: 可以使用wget -O config.yaml [订阅链接]直接从网上获取配置文件 <br />
>> 4.在一切都准备好前还有最重要的代理地址未配置(默认是127.0.0.1:7890) <br />
>> 在`/etc/environment`和`~/.zshrc或~/.bashrc`下配置[proxy](#proxy) <br />
>> 5.在按下<strong>`curl -L www.google.com`</strong>之前至少先把<a style="color:red">clash-daemon</a>打开吧! <br />
>> `systemctl enable --now clash.service` `systemctl start clash`
>> `systemctl status clash` 可能会用到<a style="color:black">`systemctl daemon-reload`</a><br />
>>
> 好像到这里就差不多结束网络配置了，接下来还有比较重要的aur包管理工具yay的安装 

### ！在安装yay之前一定要配置好clash

> yay安装(paru也可选装)
>> <s>sudo pacman -S yay</s> <br />
>> `pacman -Sy needed git base-devel` <br />
>> `git clone https://aur.archlinux.org/yay.git` || `git clone https://aur.archlinux.org/paru.git` <br />
>> `makepkg -si` <br />
>> 

### ! 别忘了准备一个非root用户
<code>
useradd -m -G wheel -s /bin/zsh myusername <br />
passwd myusername <br />
EDITOR=vim visudo <br />
去掉# #wheel ALL=(ALL:ALL) ALL
</code>



#### 问题: fcitx5 输入法的问题
- 在/etc/environment中添加[wayland设置](#wayland_config)
- 使用桌面项实现启动软件时添加启动参数[桌面项](#desktop)
#### 额外: 输入法以及字体的设置
<ol>
<li style="color:#042940">
    系统默认字体设置文件"FontConfig",字体文件路径<code>/usr/share/fonts</code>,<code>~/.local/share</code>,FontConfig将在这些路径下递归查找字体
</li>

<li>
    常用字体相关命令: 列出已知字体<code>fc-list ':' file</code><br />
    刷新字体缓存: <code>fc-cache -vf</code> <br />
    查看默认字体: <code>fc-match</code>
</li>

<li>
    修改默认字体的配置文件在路径: <code> ~/.config/fontconfig/conf.d</code> <br />
    <a href="#font_config" title="字体配置" />字体配置</a>   
</li>
</ol>

### !猜你想要
- google-chrome ~/.config/chrome-flags.conf-->加上参数
- code-oss ~/.config/code-flags.conf-->加上参数
- gwenview
- qbittorrent-enhanced
- wps2019
- yesplaymusic
- linuxqq
- obs-studio
- ......



------------------


<a style="color:yellowgreen" id="clash_service">
[Unit] <br />
Description=clash daemon <br />
After=network.target <br />
[Service] <br />
Type=simple <br />
User=yourname <br />
ExecStart=/opt/clash/clash -f ~/.config/clash/config.yaml <br />
Restart=on-failure <br />
RestartSec=5 <br/>
[Install] <br />
WantedBy=multi-user.target
</a>

<br />
<a style="color:pink" id="proxy">
http_proxy="127.0.0.1:7890" <br />
https_proxy="127.0.0.1:7890" <br />
ftp_proxy="127.0.0.1:7890" <br />
</a>
<br />
<a style="color:#2FB1E0" id="wayland_config">
GTK_IM_MODULE=fcitx <br/>
QT_IM_MODULE=fcitx <br/>
XMODIFIERS=@im=fcitx <br/>
SDL_IM_MODULE=fcitx <br/>
GLFW_IM_MODULE=ibus <br/>
</a>    
<br />
<a style="color:#E0B44C" id="desktop">
桌面项文件位置一般位于 <br />
`/usr/share/application || /usr/local/share/application` <br />
`~/.local/share/applications` <br />
文件示例<br />
[Desktop Entry] <br />

\# type关键字<br/>
Type=Application

\# 本文件所遵循的桌面项规范版本<br/>
Version=1.0

\# 应用程序的名称 <br/>
Name=xxx

\# 显示为工具提示的注释<br/>
Comment=XXXX

\# 可执行文件所在的目录<br/>
Path=/exec/of/path

\# 可执行文件，可以带参<br/>
Exec=/path/to/exec --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime

\# 图标名称<br/>
Icon=xxx

......
</a>

<a style="color:#DBF227" id="font_config">
<code>
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
<!-- created by WenQuanYi FcDesigner v0.5 -->
<match>
	<test name="family"><string>sans-serif</string></test>
	<edit name="family" mode="prepend" binding="strong">
		<string>WenQuanYi Micro Hei</string>
		<string>DejaVu Sans</string>
		<string>Microsoft Yahei</string>
	</edit>
</match>
<match>
	<test name="family"><string>serif</string></test>
	<edit name="family" mode="prepend" binding="strong">
		<string>DejaVu Serif</string>
		<string>WenQuanYi Bitmap Song</string>
	</edit>
</match>
<match>
	<test name="family"><string>monospace</string></test>
	<edit name="family" mode="prepend" binding="strong">
		<string>WenQuanYi Micro Hei Mono</string>
		<string>DejaVu Sans Mono</string>
	</edit>
</match>
</fontconfig>
</code>
</a>
