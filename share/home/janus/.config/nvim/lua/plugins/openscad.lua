return {
  "salkin-mada/openscad.nvim",
  dependencies = { "L3MON4D3/LuaSnip", "junegunn/fzf.vim" },   -- 可选依赖
  config = function()
    vim.g.openscad_load_snippets = true                        -- 加载代码片段
    require("openscad")
  end,
}
