#!/bin/sh

current=$(aerospace list-workspaces --focused)

for sid in 1 2 3 4 5; do
  if [ "$current" = "$sid" ]; then
    sketchybar --set space."$sid" icon="●" icon.color=0xffc8d3f5
  else
    sketchybar --set space."$sid" icon="○" icon.color=0xffc8d3f5
  fi
done