#! /bin/bash

# 开机自动启动niri
# 非开机启动fish
if [[ "$(tty)" == "/dev/tty1" ]]; then
  exec dbus-run-session niri
else
  exec fish
fi
