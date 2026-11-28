return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- kdljs 是 npm 包，mason 可能不管理它，这里先移除或保留你原有的其他工具
      ensure_installed = {},
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kdl = function(bufnr)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          if fname:match("niri") then
            return {}
          end
          -- 非 niri 的 kdl 文件，使用我们自定义的 kdljs 格式化器
          return { "kdljs_custom" }
        end,
      },
      formatters = {
        kdljs_custom = {
          command = "node",
          -- 这里通过 -e 参数执行一段 JS 代码来读取 stdin 并输出格式化结果
          -- 注意：这要求你的系统里已安装 kdljs (例如 npm install -g kdljs)
          args = {
            "-e",
            [[
              const { parse, format } = require('kdljs');
              let input = '';
              process.stdin.on('data', chunk => input += chunk);
              process.stdin.on('end', () => {
                try {
                  const doc = parse(input);
                  // 关键：preferIdentifierString 设为 false，以保留引号
                  process.stdout.write(format(doc, { preferIdentifierString: false }));
                } catch (e) {
                  // 解析失败时原样输出，避免破坏文件
                  process.stdout.write(input);
                }
              });
            ]],
          },
          stdin = true,
        },
      },
    },
  },
}
