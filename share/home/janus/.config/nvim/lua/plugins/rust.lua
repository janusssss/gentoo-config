return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- 设置 rust-analyzer
    vim.lsp.enable("rust_analyzer")

    -- 自动格式化
    local format_sync_grp = vim.api.nvim_create_augroup("RustFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rs",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
      group = format_sync_grp,
    })

    -- Rustaceanvim 配置
    vim.g.rustaceanvim = {
      tools = {
        rustfmt = {
          default_settings = {
            edition = "2021",
          },
        },
      },
    }
  end,
  event = { "BufReadPre", "BufNewFile" },
  ft = { "rust", "rs" },
}
