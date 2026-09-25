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
function sudo-command
    set -l cmd $argv[1]
    set -l args $argv[2..-1]
    command sudo $cmd $args
end
alias reboot='sudo-command reboot'
alias poweroff='sudo-command poweroff'
alias rc-service='sudo-command rc-service'
alias rc-status='sudo-command rc-status'
alias emerge='sudo-command emerge'
alias eselect='sudo-command eselect'

# grub
abbr grub 'LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 sudo grub-mkconfig -o /boot/grub/grub.cfg'
