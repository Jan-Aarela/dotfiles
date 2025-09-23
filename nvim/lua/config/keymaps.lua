-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Window resize
map("n", "<A-Left>", "<C-w>5<", { desc = "Reduce window width" })
map("n", "<A-Right>", "<C-w>5>", { desc = "Increase window width" })
map("n", "<A-Down>", "<C-w>5-", { desc = "Reduce window heigth" })
map("n", "<A-Up>", "<C-w>5+", { desc = "Increase window height" })

-- Window movement
map("n", "<C-left>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-right>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-down>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-up>", "<C-w>k", { desc = "switch window up" })

-- Copy and paste
map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map("v", "<C-v>", "p", { desc = "paste" })

-- nvim-tree
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })

-- Undotree toggle
map("n", "<C-u>", "<cmd>UndotreeToggle<cr>", { desc = "Toggle Undotree" })

-- Next and previous buffer
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
