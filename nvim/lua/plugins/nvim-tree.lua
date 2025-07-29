return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "name",
      },
      git = {
        enable = true,
      },
    })
  end,
}
