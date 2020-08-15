#!/usr/bin/env bash

# Dracula palette
# ref: https://github.com/dracula/dracula-theme
BACKGROUND=#282a36
CURRENT=#44475a
SELECTION=#44475a
FOREGROUND=#f8f8f2
COMMENT=#6272a4
CYAN=#8be9fd
GREEN=#50fa7b
ORANGE=#ffb86c
PINK=#ff79c6
PURPLE=#bd93f9
RED=#ff5555
YELLOW=#f1fa8c

OUTPUT=$(/usr/bin/nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{ print "scale=2;x=7*(" $1 "/100);scale=0;x/1"}' | bc)

case $OUTPUT in
  0)
    RAMP="%{F$GREEN}▁%{F-}"
    ;;
  1)
    RAMP="%{F$GREEN}▂%{F-}"
    ;;
  2)
    RAMP="%{F$YELLOW}▃%{F-}"
    ;;
  3)
    RAMP="%{F$YELLOW}▄%{F-}"
    ;;
  4)
    RAMP="%{F$ORANGE}▅%{F-}"
    ;;
  5)
    RAMP="%{F$ORANGE}▆%{F-}"
    ;;
  6)
    RAMP="%{F$RED}▇%{F-}"
    ;;
  7)
    RAMP="%{F$RED}█%{F-}"
    ;;
esac

echo $RAMP
