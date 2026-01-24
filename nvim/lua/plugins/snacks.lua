return {
  "snacks.nvim",
  opts = {
    scroll = { enabled = false },
    notifier = {
      enabled = true,
      timeout = 4000,
    },

    terminal = {
      win = {
        style = "float",
        relative = "editor",
        width = 0.75,
        height = 0.75,
        border = "rounded", -- Use 'single', 'double', 'rounded', 'solid', or an array of characters
      },
    },
  },
}
