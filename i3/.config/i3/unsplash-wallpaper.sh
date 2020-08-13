#!/bin/bash
wget "https://source.unsplash.com/featured/3840x2160/daily/?cat" -O /tmp/wallpaper.jpg
feh --bg-scale /tmp/wallpaper.jpg
