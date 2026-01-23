-- vim:foldmethod=marker
return {
  -- Set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = vim.env.TERM == "linux" and "wildcharm" or "catppuccin-mocha",
    },
  },

  -- Catppuccin {{{
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        nvimtree = true,
        telescope = true,
        which_key = true,
        noice = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    },
  },
  -- }}}

  -- kanagawa {{{
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent_background = true,
      integrations = {
        noice = true,
        telescope = true,
      },
    },
  },
}
-- }}}
