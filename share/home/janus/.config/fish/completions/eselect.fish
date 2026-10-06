# fish completion for eselect
# Ported from Gentoo's bash-completion (eselect)
# Place at: ~/.config/fish/completions/eselect.fish

# ---- 辅助函数 ----------------------------------------------------------

# 获取全局选项
function __eselect_global_options
    printf '%s\n' --brief --color= --colour= --eprefix= --root=
end

# 已输入的命令行 token（排除掉命令名本身和当前正在补全的词）
function __eselect_tokens
    set -l tokens (commandline -opc)   # 已经输入完成的部分，不含当前词
    set -e tokens[1]                    # 去掉 "eselect"
    for t in $tokens
        printf '%s\n' $t
    end
end

# 判断当前是否处于"还没有输入任何子命令"的位置
function __eselect_use_module
    set -l tokens (__eselect_tokens)
    # 跳过以 - 开头的全局选项
    for t in $tokens
        if not string match -q -- '-*' $t
            return 1
        end
    end
    return 0
end

# 获取模块列表
function __eselect_modules
    eselect modules list --only-names 2>/dev/null
end

# 获取某个模块的可用 action（set/enable/disable/list 等）
function __eselect_module_actions
    set -l module $argv[1]
    eselect --brief $module usage 2>/dev/null | \
        string replace -r '^\s+([[:alnum:]-][[:alnum:]_-]*)[[:space:],].*$' '$1'
end

# 获取某个模块 list 输出的条目（用于 set/enable/disable）
function __eselect_module_items
    set -l module $argv[1]
    eselect $module list 2>/dev/null | \
        string replace -r '^\s+\[[0-9]+\]\s*([^\s]+).*$' '$1'
end

# ---- 补全规则 ----------------------------------------------------------

# 关闭默认的文件名补全
complete -c eselect -f

# 1) 全局选项
complete -c eselect -n '__eselect_use_module' \
    -a '(__eselect_global_options)'

# 2) 模块名（当还没有输入任何模块时）
complete -c eselect -n '__eselect_use_module' \
    -a '(__eselect_modules)'

# 3) 模块后的 action（list / set / enable / disable / update / show ...）
complete -c eselect -n 'not __eselect_use_module; and test (count (__eselect_tokens)) -eq 1' \
    -a '(__eselect_module_actions (__eselect_tokens)[1])'

# 4) set / enable / disable 后面的条目
complete -c eselect -n '
    set -l t (__eselect_tokens);
    test (count $t) -ge 2;
    and contains -- $t[2] set enable disable
' -a '(__eselect_module_items (__eselect_tokens)[1])'

# 5) 让 --color=/--colour=/--root=/--eprefix= 后面不补空格
complete -c eselect -l color  -r
complete -c eselect -l colour -r
complete -c eselect -l root   -r
complete -c eselect -l eprefix -r
