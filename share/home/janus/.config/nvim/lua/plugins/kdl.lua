return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "kdlfmt" }, -- 缺了就自动装
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kdl = { "kdlfmt" }, -- kdl 格式化，cargo install kdlfmt
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)

      -- 保存时自动格式化 kdl 文件
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.kdl" },
        callback = function()
          conform.format({ async = false, lsp_fallback = true })
        end,
      })
    end,
  },
}
