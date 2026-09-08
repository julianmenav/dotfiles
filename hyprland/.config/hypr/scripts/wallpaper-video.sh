#!/bin/sh
# Video wallpaper: (re)start mpvpaper on every output, on top of hyprpaper.
# Run by hyprland.conf at login and by hypridle after suspend: mpvpaper keeps its layer but
# stops drawing on an output that went away while the machine slept.
# The file is not in the repo; fetch it with:
#   yt-dlp -f 620 -o ~/Videos/wallpapers/waneella-lull.mp4 'https://www.youtube.com/watch?v=PSBjS2xppec'
#   ffmpeg -ss 10 -i ~/Videos/wallpapers/waneella-lull.mp4 -frames:v 1 ~/Videos/wallpapers/waneella-lull.png
# -p pauses under fullscreen windows, panscan fills 16:9.
pkill -x mpvpaper
exec mpvpaper -p -o "no-audio loop hwdec=auto panscan=1.0" '*' ~/Videos/wallpapers/waneella-lull.mp4
