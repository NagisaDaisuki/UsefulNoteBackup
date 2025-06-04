## ffmpeg 是音、视频处理的一个强大开源工具，它包含许多组件和扩展库，在视频网站和商业软件被大量应用。它还有一个命令行工具，在很多场景下直接使用ffmpeg命令行工具比桌面视频处理软件更简洁高效。

使用 `ffmpeg` 前，可先简单了解下视频处理的一些基本概念：

**封装(Container)格式**：也可翻译为容器，里面包括了视频、音频、字幕等内容。对视频来说，封装格式是mp4、avi、mkv等格式。

**流(Stream)**：stream是指媒体文件中的一个单独的数据通道。一个媒体文件可以包含多个流，如视频、音频、字幕等。ffmpeg本质上是操作和处理这些媒体流，比如提取、分离、合并、转码等。你可以选择特定的流进行处理，或者将多个流合并成一个新的媒体文件。

**帧(Frame)**：帧代表最小数据单元，也是编解码器真正处理的最小处理单元。对于视频来说，帧(Frame)是编码器编码后的一个图像；对于音频来说，帧(Frame)是编码器编码后的一个声音。帧分为：I帧:关键帧、P帧:预测帧、B帧:双向预测帧。编解码(Codec)：编码是指对图像和声音的打包或压缩方法；解码就是把编码后的东西还原为原来的状态。编码格式：视频和音频都需要经过编码，才能保存成文件。不同的编码格式，有不同的压缩率，会导致文件大小和清晰度的差异。常用的编码格式有H.264、H.265等。


# 🎞 视频处理
## 1.转码为MP4
~~~
ffmpeg -i input.mov -vcodec libx264 -acodec aac output.mp4
~~~
也可以添加额外参数
~~~
ffmpeg -i input.mov -c:v libx264 -c:a aac -preset medium -crf 23 output.mp4
~~~
- `-c:v`和`-c:a`分别是`-vcodec`和`-acodec`的alias
- `libx264`：转换为H.264（兼容性最好）
- `aac`：音频转为AAC（兼容广泛）
- `-crf 23`：保持较好画质，文件不会太大
- `-preset medium`：转码速度与压缩比的平衡
## 2.裁剪视频(不重新编码)
~~~
ffmpeg -ss 00:00:10 -i input.mp4 -t 00:00:20 -c copy output.mp4
~~~
`-ss`是起始时间，`-t`是持续时间，`-c copy`表示不改变音频和视频的编码格式，直接拷贝
## 3.修改分辨率
~~~
ffmpeg -i input.mp4 -vf scale=1280:720 output_720p.mp4
~~~
## 4.提取指定时间段的视频(并重新编码)
~~~
ffmpeg -ss 00:01:00 -to 00:02:00 -i input.mp4 -c:v libx264 -c:a aac output.mp4
~~~
## 5.加快或减慢播放速度
- 快两倍：
~~~
ffmpeg -i input.mp4 -vf "setpts=0.5*PTS" output_fast.mp4
~~~
- 慢0.5倍：
~~~
ffmpeg -i input.mp4 -vf "setpts=2.0*PTS" output_slow.mp4
~~~

# 🔊 音频处理
## 1.提取音频
~~~
ffmpeg -i input.mp4 -vn -acodec copy output.aac
~~~
- `vn`: 不处理视频流（只提取音频）
- `c:a aac`: 指定音频编码为 AAC（与 .aac 容器兼容）
## 2.转换为MP3
~~~
ffmpeg -i input.aac output.mp3
~~~
## 3.调整音量(放大一倍)
~~~
ffmpeg -i input.mp3 -filter:a "volume=2.0" output.mp3
~~~
## 4.混合多个音轨
~~~
ffmpeg -i audio1.mp3 -i audio2.mp3 -filter_complex amix=inputs=2:duration=longest output.mp3
~~~

# 🖼 图片处理
## 1.从视频中导出每秒一张图片
~~~
ffmpeg -i input.mp4 -vf fps=1 image_%03d.jpg
~~~
## 2.将图片序列合成为视频
~~~
ffmpeg -framerate 24 -i image_%03d.jpg -c:v libx264 -pix_fmt yuv420p output.mp4
~~~
## 3.提取视频的第一帧为封面图
~~~
ffmpeg -i input.mp4 -vf "select=eq(n\,0) -q:v 3 output.jpg"
~~~
## extra. FFmpeg 在指定时间区间内按帧提取截图
~~~cmd
ffmpeg -ss 00:00:05 -to 00:00:10 -i input.mp4 -vsync 0 -q:v 2 frame_%04d.png
~~~

## extra1. FFmpeg 指定NVIDIA GPU时间区间内按帧提取截图
~~~cmd
ffmpeg -hwaccel cuda -ss 00:00:30 -to 00:00:40 -i input.mp4 -vf fps=1 output/frame_%04d.jpg
~~~
### 📌 参数说明：
| 参数                      | 说明                            |
| ----------------------- | ----------------------------- |
| `-hwaccel cuda`         | 使用 NVIDIA GPU 加速视频解码（通过 CUDA） |
| `-i input.mp4`          | 输入视频                          |
| `-vf fps=1`             | 每秒截一帧                         |
| `output/frame_%04d.jpg` | 输出图像路径                        |

## extra2. av1转码为 H.264，再截图（兼容 + 可加速）
~~~cmd
ffmpeg -c:v libdav1d -i video.mp4 -c:v h264_nvenc -crf 23 -preset fast output_h264.mp4
~~~
然后截图：
~~~cmd
ffmpeg -hwaccel cuda -ss 00:00:30 -to 00:00:40 -i output_h264.mp4 -vf fps=1 output/frame_%04d.jpg
~~~
这样截图过程可以启用 GPU 加速（因为 H.264 你支持 NVENC/NVDEC）

✅ 可选：如果转码中出现 OBU 报错，使用 libaom-av1：
~~~cmd
ffmpeg -c:v libaom-av1 -i video.mp4 -c:v h264_nvenc -preset fast output_h264.mp4
~~~
## 4.图片格式转换
~~~
ffmpeg -i input.jfif output.png
~~~
- `-i input.jfif`：指定输入文件
- `output.png`：自动根据后缀选择PNG编码器
## 5.修改图片尺寸
~~~
ffmpeg -i input.jfif -vf scale=800:600 output.png
~~~
- `scale=宽度:高度`，可用`-1`自动按比例缩放，比如：
~~~
-vf scale=800:-1
~~~
## 6.调整输出图片质量(对有压缩的格式如JPEG更有用)
- 虽然 PNG 是无损格式，没压缩等级设置，但你可以用` -compression_level`控制压缩（越高体积越小，速度越慢）：
~~~
ffmpeg -i input.jfif -compression_level 9 output.png
~~~
范围：`0`(最快)到`9`压缩最强
## 7.裁剪图片
~~~
ffmpeg -i input.jfif -vf "crop=width:height:x:y" output .png
~~~
例如从左上角开始裁剪300x300区域：
~~~
-vf "crop=300:300:0:0"
~~~
## 8.添加水印/叠加图层
~~~
ffmpeg -i input.jfif -i logo.png -filter_complex "overlay=10:10" output.png
~~~
将`logo.png`叠加到输入图像的左上角(x=10,y=10)
## 9.转换为带透明背景(alpha)的PNG
如果原图没有alpha，但你希望创建带alpha通道的图(比如用于抠图后保存)：
~~~
ffmpeg -i input.jfif -vf "format=rgba" output.png
~~~
## 10.更改颜色格式
~~~
ffmpeg -i input.jfif -pix_fmt rgb24 output.png
~~~
常用像素格式:
- `gray`：灰度图
- `rgb24`：24位真彩色
- `rgba`：含透明度通道
- `pal8`：8位索引色(低色图)
# ✅ 示例：高质量转换 + 改尺寸 + 添加水印
~~~
ffmpeg -i input.jfif -i watermark.png -filter_complex "[0][1]overlay=W-w-10:H-h-10,scale=1024:-1" -compression_level 9 output.png
~~~
# 🔍 本地帮助手册
~~~
ffmpeg -h           # 简略帮助
ffmpeg -filter      # 所有滤镜
ffmpeg -codecs      # 所有编解码器
ffmpeg -pix_fmts    # 所有像素格式  
ffmpeg -formats     # 所有支持的格式
~~~
# 📌 补充说明：
如果你要批量转换多个 .jfif 为 .png，也可以用批处理命令（例如在 Windows 批处理脚本中）：
~~~
for %%f in (*.jfif) do ffmpeg -i "%%f" "%%~nf.png"
~~~
✅ 如果你直接在命令行中运行（不是 .bat 文件），要用 %f 而不是 %%f

## 视频格式转换补充
### 🚀 1. 启用多线程（自动或手动指定）
FFmpeg 默认会根据系统核心数自动使用多线程，但你也可以手动指定：
~~~
ffmpeg -i input.mp4 -threads 8 -c:v libx264 -preset fast output.mp4
~~~
参数说明：
- `-threads 8`：手动指定使用 8 个线程（可设为 auto）
- `libx264` 本身是支持多线程的（默认会启用）
- 一些滤镜（如 scale, hqdn3d）也会自动启用多线程

📌 注意：某些滤镜不支持多线程，比如 drawtext，即使你开了 -threads 也可能没明显效果。
### 🧠 2. 使用转码预设：`-preset`
用于 libx264 和 libx265 编码器，会影响速度和压缩比：
~~~
-preset ultrafast
-preset superfast
-preset veryfast
-preset fast
-preset medium     # 默认值
-preset slow
~~~
越“fast”，编码越快，但文件体积越大、画质压缩越弱
### 😎 3. FFmpeg纯音频合成黑场视频
~~~
ffmpeg -i your_audioi.mp3 -f lavfi -i color=c=black:s=640x480:r=30 -c:v libx264 -pix_fmt yuv420p -c:a copy -shortest output_black_video.mp4
~~~
- `-i your_audio.mp3`: 指定你的输入音频文件。替换 `your_audio.mp3` 为你的实际音频文件路径。
- `-f lavfi`:　告诉 FFmpeg 使用 `lavfi` (libavfilter input) 虚拟设备。
- `-i color=...`: 这是 `lavfi`的一个源滤镜，用于生成一个纯色视频流。
`c=black`: 设置颜色为黑色。你也可以使用其他颜色名称（如 white, red）或十六进制 RGB 值（如 c=0x000000）。
`s=1920x1080`: 设置视频分辨率为 1920x1080 (Full HD)。你可以根据需要更改这个值，例如 1280x720 (HD)。
`r=30`: 设置视频帧率为 30 fps。你也可以设置为其他帧率，例如 r=25 或 r=60。
`-c:v libx264`: 指定视频编码器为 libx264，这是最常用的 H.264 编码器。
`-pix_fmt yuv420p`: 指定像素格式为 yuv420p。这是 H.264 的标准像素格式，具有广泛的兼容性。
`-c:a copy`: 复制音频流，不重新编码。这样可以保持原始音频的音质和编码格式（例如，如果你的输入是 AAC，输出的 MP4 中音频也会是 AAC）。
`-shortest`: 这个非常重要！它告诉 FFmpeg 输出的视频时长应与最短的输入流（在这里就是你的音频文件）的持续时间保持一致。如果没有这个，FFmpeg 会生成一个无限长的黑屏视频。
`output_black_video.mp4`: 指定输出的 MP4 文件名。