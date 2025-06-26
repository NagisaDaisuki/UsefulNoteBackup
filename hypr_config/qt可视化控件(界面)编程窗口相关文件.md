## 窗口相关的文件
- 窗口界面设计和界面组件的事件处理是GUI程序设计的主要任务

<h4><center>与窗口相关的四个文件</center></h4>

| 文件📄 | 说明 |
| --- | --- |
| widget.h | 定义了窗口类Widget |
| widget.cpp | 实现Widget类的功能的源程序文件 |
| widget.ui | 窗口UI文件，用于在Qt Designer中进行UI可视化设计。widget.ui是一个XML文件，存储界面上各个组件的属性和布局内容|
| ui_widget.h | UI文件经过UIC编译后生成的文件 |

<ol>
    <li>
        文件widget.h  
        选择窗口基类是QWidget
    </li>
    <li>
        文件widget.cpp
        对应文件widget.h 的源程序文件
    </li>
    <li>
        文件widget.ui
        窗口界面定义文件，是一个XML文件
    </li>
    <li>
        文件ui_widget.h
        这个文件并不会出现在Qt Creator 的项目管理目录树下
        它是构建项目时的一个中间文件
    </li>
</ol>
