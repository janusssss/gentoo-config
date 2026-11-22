# 登录 tty1 时自动启动 niri 会话（若未运行）
# 想临时跳过：export NIRI_NO_AUTOSTART=1 后重新登录
if status is-interactive
    and test (tty) = /dev/tty1
    and not set -q NIRI_NO_AUTOSTART
    and not pgrep -x niri >/dev/null
    exec /home/janus/.local/bin/niri-session
end
