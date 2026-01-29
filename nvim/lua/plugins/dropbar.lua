return {
  "Bekaboo/dropbar.nvim",
  -- optional, but required for fuzzy finder support
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  config = function()
    -- Use treesitter instead of LSP
    local sources = require("dropbar.sources")
    require("dropbar").setup({
      bar = {
        sources = {
          -- sources.path,
          sources.treesitter,
        },
      },
    })

    -- Theming
    local dropbar_api = require("dropbar.api")
    vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })

    vim.api.nvim_set_hl(0, "WinBar", { bg = "#202030", fg = "", bold = true, underline = true, sp = "#45475a" })
    -- vim.api.nvim_set_hl(0, "WinBar", { bg = "#202030", fg = "", bold = true })
    -- vim.api.nvim_set_hl(0, "WinBarNC", { bg = "#202030", fg = "" })
  end,
}
