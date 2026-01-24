return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.options.section_separators = { left = "", right = "" }
    opts.options.component_separators = { left = "\\", right = "/" }

    local theme = require("lualine.themes.auto")
    opts.options.theme = theme

    theme.normal.c.bg = "#202030"
    theme.inactive.c.bg = "#202030"

    opts.sections.lualine_c = {
      {
        function()
          local git_dir = vim.fs.find(".git", {
            path = vim.fn.expand("%:p:h"),
            upward = true,
          })[1]

          if git_dir then
            return vim.fn.fnamemodify(vim.fn.fnamemodify(git_dir, ":h"), ":t")
          end
          return ""
        end,
        icon = {
          "",
          color = { fg = theme.normal.a.bg },
        },
        color = { fg = theme.normal.c.fg },
        padding = { left = 1, right = 1 },
        cond = function()
          return vim.fs.find(".git", { path = vim.fn.expand("%:p:h"), upward = true })[1] ~= nil
        end,
      },
      {
        "filetype",
        icon_only = true,
        separator = "",
        padding = { left = 1, right = 0 },
      },
      {
        "filename",
        path = 3,
        symbols = { modified = "", readonly = "", unnamed = "" },
        padding = { left = 0, right = 1 },

        color = function()
          if vim.bo.readonly then
            return { fg = theme.replace.a.bg, gui = "bold" }
          elseif vim.bo.modified then
            return { fg = theme.command.a.bg, gui = "bold" }
          else
            return { fg = theme.normal.c.fg }
          end
        end,
      },
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
      },
    }
  end,
}
