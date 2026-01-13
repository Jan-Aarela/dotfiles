-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = false

vim.opt.swapfile = false
-- vim.opt.clipboard = ""

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[ set nofoldenable]])

-- vim.opt.whichwrap:append("<,>,h,l,[,]")
-- vim.opt.backspace = { "indent", "eol", "start" }
