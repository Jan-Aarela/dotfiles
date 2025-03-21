require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<C-left>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-right>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-down>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-up>", "<C-w>k", { desc = "switch window up" })

map('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
map('v', '<C-v>', 'p', { desc = 'paste' })
