if status is-interactive
    # Commands to run in interactive sessions can go here
    # 设置打开欢迎语
    set fish_greeting "$(date)"
end

starship init fish | source

# 替换ls命令
function ls
    command eza --icons $argv
end

# 命令加sudo
set -l cmds \
    rc-update rc-service rc-status emerge eselect \
    chmod pkill \
    reboot poweroff

for cmd in $cmds
    function $cmd --inherit-variable cmd
        sudo $cmd $argv
    end
end

# grub
abbr grub 'LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 sudo grub-mkconfig -o /boot/grub/grub.cfg'
