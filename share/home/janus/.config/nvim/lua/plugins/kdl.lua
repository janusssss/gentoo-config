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
  },
}
