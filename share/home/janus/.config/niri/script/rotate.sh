#!/bin/bash

# 用你实际的屏幕名称替换下面的 OUTPUT
OUTPUT="eDP-1"

# 监听传感器输出，并根据方向执行 Niri 命令
monitor-sensor --accel | while read -r line; do
    if echo "$line" | grep -q "orientation changed: normal"; then
        niri msg output "$OUTPUT" transform normal
    elif echo "$line" | grep -q "orientation changed: left-up"; then
        niri msg output "$OUTPUT" transform 90
    elif echo "$line" | grep -q "orientation changed: right-up"; then
        niri msg output "$OUTPUT" transform 270
    elif echo "$line" | grep -q "orientation changed: bottom-up"; then
        niri msg output "$OUTPUT" transform 180
    fi
done
