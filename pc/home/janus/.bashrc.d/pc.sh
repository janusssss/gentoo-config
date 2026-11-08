#! /bin/bash

# 开机自动启动niri
# 非开机启动fish
if [[ "$(tty)" == "/dev/tty1" ]]; then
  export NIRI_BACKEND=headless
  exec dbus-run-session /usr/local/bin/niri
else
  exec fish
fi
