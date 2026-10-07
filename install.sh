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
  --dry-run) dry_run="try" ;;
  --pc) platform="pc" ;;
  --surface) platform="surface" ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    echo "未知参数: $arg" >&2
    usage >&2
    exit 2
    ;;
  esac
done

if [[ -z ${platform:-} ]]; then
  exit "no platform"
fi

make_link() {
  local path="$1"
  local dest="/$path"
  run_or_try "rm -rf $dest"
  if [ -L "$path" ]; then
    run_or_try "cp -d $path $dest"
  else
    target=$(realpath "$path")
    run_or_try "ln -s $target $dest"
  fi
}

run_or_try() {
  if [[ $dry_run == "try" ]]; then
    echo $1
    return
  fi
  eval $1
}

make_link_curr_dir() {
  git ls-files | while IFS= read -r file; do
    make_link "$file"
  done
}

cd ./share
make_link_curr_dir

if [[ $platform == "surface" ]]; then
  cd ../surface
  make_link_curr_dir
fi

if [[ $platform == "pc" ]]; then
  cd ../pc
  make_link_curr_dir
fi

echo "make config in $platform done"
