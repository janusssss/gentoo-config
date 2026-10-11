-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- LazyVim 默认在 SSH 下会把 clipboard 置空（本机才是 unnamedplus），
-- 这里统一强制 unnamedplus，让 yy 无条件同步到系统剪贴板
vim.opt.clipboard = "unnamedplus"

-- SSH 会话下用 OSC52：yy 的内容以转义序列经 tty 发回客户端终端，
-- 客户端 Ctrl+V 即可粘贴（宿主机 cliplist 不会记录这条路径）
if vim.env.SSH_CONNECTION then
  vim.g.clipboard = {
    name = "osc52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
