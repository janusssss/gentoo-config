return {
  -- 文件树
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          -- 默认隐藏所有隐藏文件和忽略文件
          hidden = true,
          ignored = false,
          -- 使用 include 强制显示指定路径（优先于隐藏/忽略规则）
          include = {
            ".gitignore",
            "home/janus/.config",
          },
          -- exclude = {
          --  "boot/",
          -- },
        },
      },
    },
  },
}
