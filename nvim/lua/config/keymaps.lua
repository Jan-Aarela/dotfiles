-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keybinds {{{
local map = LazyVim.safe_keymap_set

-- Window resize
map("n", "<A-Left>", "<C-w>16<", { desc = "Reduce window width" })
map("n", "<S-A-Left>", "<C-w>4<", { desc = "Increase window height" })
map("n", "<A-Right>", "<C-w>16>", { desc = "Increase window width" })
map("n", "<S-A-Right>", "<C-w>4>", { desc = "Increase window height" })
map("n", "<A-Down>", "<C-w>8-", { desc = "Reduce window heigth" })
map("n", "<S-A-Down>", "<C-w>2-", { desc = "Increase window height" })
map("n", "<A-Up>", "<C-w>8+", { desc = "Increase window height" })
map("n", "<S-A-Up>", "<C-w>2+", { desc = "Increase window height" })

-- Window movement
map("n", "<C-left>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-right>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-down>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-up>", "<C-w>k", { desc = "switch window up" })

-- Copy and paste
map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
-- map("n", "<C-v>", "p", { desc = "paste" })

-- Undotree toggle
map("n", "<C-u>", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undotree" })

-- Next and previous buffer
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
-- }}}

-- LSP toggle {{{
local function toggle_lsp()
  local clients = vim.lsp.get_active_clients()
  print(#clients)
  if #clients > 0 then
    print("LSP: OFF (LspStop)")
    vim.cmd("LspStop")
  else
    print("LSP: ON (LspStart)")
    vim.cmd("LspStart")
  end
end
-- }}}

-- Which-key binds {{{
local wk = require("which-key")
wk.add({
  {
    "<leader>t",
    function()
      Snacks.terminal.toggle(nil, {
        cwd = vim.fn.getcwd(),
      })
    end,
    desc = "CWD Terminal",
  },
})

wk.add({
  {
    "<leader>l",
    toggle_lsp,
    desc = "Toggle LSP On/Off",
  },
})
-- }}}
