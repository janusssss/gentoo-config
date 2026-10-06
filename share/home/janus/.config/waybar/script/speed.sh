#!/bin/sh

# 1. 读取上次状态（或初始化）
STATE_FILE="/tmp/waybar-netstats"
if [ -f "$STATE_FILE" ]; then
  read LAST_BYTES LAST_TIME <"$STATE_FILE"
else
  LAST_BYTES=0
  LAST_TIME=$(date +%s)
fi

# 2. 获取当前值
CURRENT_BYTES=$(cat /sys/class/net/wlan0/statistics/rx_bytes 2>/dev/null)
CURRENT_TIME=$(date +%s)

# 3. 计算精确速度（核心！）
TIME_DIFF=$((CURRENT_TIME - LAST_TIME))
if [ $TIME_DIFF -gt 0 ]; then
  BYTES_DIFF=$((CURRENT_BYTES - LAST_BYTES))
  [ $BYTES_DIFF -lt 0 ] && BYTES_DIFF=$CURRENT_BYTES # 处理系统重启
  SPEED_BPS=$(echo "scale=2; $BYTES_DIFF / $TIME_DIFF" | bc)
else
  SPEED_BPS=0
fi

# 4. 保存状态供下次使用
echo "$CURRENT_BYTES $CURRENT_TIME" >"$STATE_FILE"

# 5. 格式化输出
HUMAN_SPEED=$(numfmt --to=iec --suffix=B --format="%.2f" "$SPEED_BPS" 2>/dev/null)
echo "$HUMAN_SPEED/s"
