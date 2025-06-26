## A Solution to you Wayland Wallpaper Woes

Efficient animated wallpaper daemon for wayland,controlled at runtime  

### Dependencies

### Usage

Start by initializing the daemon

~~~
swww-daemon
~~~

Then,in a different terminal, simply pass the image you want to display

~~~
swww img <path/to/img>

# You can also specify outputs:
swww img -o <outputs> <path/to/img>

# Control how smoothly the transition will happen and/or it's frame rate
# For the step, smaller values = more smooth. Default = 20
# For the frame rate, default is 30.
swww img <path/to/img> --transition-step <1 to 255> --transition-fps <1 to 255>

# There are also many different transition effects:
swww img <path/to/img> --transition-type center

# Note you may also control the above by setting up the SWWW_TRANSITION_FPS,
# SWWW_TRANSITION_STEP, and SWWW_TRANSITION environment variables.

# To see all options, run
swww img --help
~~~