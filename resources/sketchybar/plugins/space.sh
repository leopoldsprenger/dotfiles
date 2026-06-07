#!/bin/sh

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" background.drawing=true icon.color=0xff82aaff
else
  sketchybar --set "$NAME" background.drawing=false icon.color=0xffc8d3f5
fi
