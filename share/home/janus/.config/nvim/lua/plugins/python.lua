return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff" }, -- 使用 ruff 替代
      },
    },
  },
}
