#!/usr/bin/env bash
#   ./install.sh            # 补链（首次部署 & 仓库新增文件后跑）
#   ./install.sh --dry-run  # 只看会做什么，不实际创建
set -euo pipefail

dry_run=0

usage() {
  sed -n '2,3s/^#   /用法: /p' "$0"
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "未知参数: $arg" >&2; usage >&2; exit 2 ;;
  esac
done

cd ./share
git ls-files -z | while IFS= read -r -d '' file; do
  dest="/$file"
  if [ "$dry_run" = 1 ]; then
    if [ -L "$file" ]; then
      echo "[dry-run] cp -a -- ./share/$file -> $dest"
    else
      echo "[dry-run] ln -s -- $(realpath "$file") -> $dest"
    fi
    continue
  fi
  rm -rf "$dest"
  if [ -L "$file" ]; then
    cp -a "$file" "$dest"
  else
    ln -s "$(realpath "$file")" "$dest"
  fi
done
