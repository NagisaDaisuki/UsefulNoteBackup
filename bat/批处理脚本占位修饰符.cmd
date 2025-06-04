chcp 65001 >nul
@echo off
setlocal enabledelayedexpansion
:: bat脚本中的占位修饰符

REM FOR 命令的文件解析功能
REM 这里的核心是 FOR 命令的文件解析修饰符。
REM FOR 命令不仅可以遍历文件集，当它遍历一个文件路径时，
REM 它还可以将这个路径分解成各个组成部分（驱动器、路径、文件名、扩展名等）。
REM %%~nxi: 文件名 + 扩展名 report_2024.docx
REM %%~dpi: 驱动器号 + 路径
REM %%~fsi: 短格式的完整路径名(不常用) D:\MYDOCU~1\PROJECTS\REPORT~1.DOC
REM %%~i: 原始值(原始循环变量) 如果为完整路径则与fi相同，如果只是文件名则输出文件名。
REM 用于去除引号
REM %%~fi: 完整路径名(包含驱动器和路径)
REM 确保获取文件绝对路径时使用
REM %%~xi 扩展名(包含点)
REM %%~ni 文件名(不含路径)
REM %%~zi 文件大小(字节数)


set "inputFile="
set /p "inputFile=请输入一个合法的文件路径："
for %%i in ("!inputFile!") do (
    set "inputDir=%%~dpi" :: 显示文件的路径(不显示文件名本身)
    set "inputFileName=%%~ni" :: 显示文件名
)

:: 例子一 循环路径本就是完整路径
set "myFile="D:\Epi11_Coding\reg\enable_gbk_console.reg"

for %%i in (%myFile%) do (
    echo %%~i: %%~i
    echo %%~fi: %%~fi
)

:: 例子二 循环变量只是文件名
cd /d "D:\Epi11_Coding\reg"
echo. > my_document.txt REM 创建一个测试文件

for %%i in ("my_document.txt") do (
    echo %%~i:      %%~i
    echo %%~fi:     %%~fi
)

pause