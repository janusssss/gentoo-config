return {
  "mason-org/mason-lspconfig.nvim", -- 主插件，负责桥接 mason 和 lspconfig
  dependencies = {
    "neovim/nvim-lspconfig", -- LSP 配置核心
    "mason-org/mason.nvim", -- LSP/Debuggers/Linters 管理器 (需要单独配置和安装)
    "p00f/clangd_extensions.nvim", -- 可选扩展
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "clangd" }, -- 确保 clangd 已通过 mason 安装
      handlers = {
        clangd = function()
          require("lspconfig").clangd.setup({
            filetypes = { "c", "cpp", "objc", "objcpp" },
            -- 其他 clangd 特定选项...
          })
        end,
        -- 你可以为其他 LSP 服务器添加处理程序
      },
    })

    -- 格式化配置 (与之前相同)
    local format_sync_grp = vim.api.nvim_create_augroup("CppFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.c", "*.cpp", "*.cc", "*.cxx", "*.h", "*.hpp", "*.hxx" },
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
      group = format_sync_grp,
    })
  end,
  event = { "BufReadPre", "BufNewFile" },
  ft = { "c", "cpp", "objc", "objcpp" },
  -- mason-lspconfig 通常不需要 build
  -- build = nil,
}
