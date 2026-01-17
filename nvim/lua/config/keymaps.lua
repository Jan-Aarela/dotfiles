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

-- Smart Comment {{{
-- TODO: perfile configs. eg for css.
-- double sided comments

vim.keymap.set("i", "<S-CR>", function()
  local line = vim.api.nvim_get_current_line()
  local comment_leader = line:match("^%s*([/%*%-#]+%s*)")

  if comment_leader then
    return "<CR>" .. comment_leader
  else
    return "<CR>"
  end
end, { expr = true, desc = "Force comment line with Shift+Enter" })
-- }}}

-- LSP toggle {{{
local function toggle_lsp()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a<Esc>", true, false, true), "n", false)

  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if not lsp_hidden then
    for _, client in ipairs(clients) do
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
    lsp_hidden = true
    vim.notify("LSP Detached", vim.log.levels.WARN)
  else
    vim.cmd("LspStart")
    vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr })
    lsp_hidden = false
    vim.notify("LSP Re-attached", vim.log.levels.INFO)
  end
end
-- }}}

-- Boolean toggle {{{
local function toggle_bool()
  local word = vim.fn.expand("<cword>")
  local toggles = {
    -- Classic Booleans
    ["true"] = "false",
    ["false"] = "true",
    ["True"] = "False",
    ["False"] = "True",
    ["TRUE"] = "FALSE",
    ["FALSE"] = "TRUE",

    -- Binary/Bit
    ["0"] = "1",
    ["1"] = "0",

    -- Logic/Status
    ["yes"] = "no",
    ["no"] = "yes",
    ["YES"] = "NO",
    ["NO"] = "YES",
    ["Yes"] = "No",
    ["No"] = "Yes",

    ["on"] = "off",
    ["off"] = "on",
    ["On"] = "Off",
    ["Off"] = "On",
    ["ON"] = "OFF",
    ["OFF"] = "ON",

    -- Features
    ["enabled"] = "disabled",
    ["disabled"] = "enabled",
    ["Enabled"] = "Disabled",
    ["ENABLED"] = "DISABLED",
    ["DISABLED"] = "ENABLED",
    ["Disabled"] = "Enabled",

    -- State
    ["active"] = "inactive",
    ["inactive"] = "active",
    ["Active"] = "Inactive",
    ["Inactive"] = "Active",
    ["ACTIVE"] = "INACTIVE",
    ["INACTIVE"] = "ACTIVE",

    -- Null/Existence
    -- ["nil"] = "not nil",
    -- ["None"] = "Some",
  }

  if toggles[word] then
    vim.cmd("normal! ciw" .. toggles[word])
  else
    vim.notify("Not a boolean!", vim.log.levels.WARN)
  end
end

-- }}}

-- Which-key binds {{{
local wk = require("which-key")

-- lps
wk.add({
  {
    "<leader>l",
    toggle_lsp,
    desc = "Toggle LSP On/Off",
  },
})

-- relative number
wk.add({
  {
    "<leader>r",
    "<cmd>set rnu!<CR>",
    desc = "Toggle Relativenumber",
  },
})

-- boolean toggle
wk.add({
  {
    "<leader>T",
    toggle_bool,
    desc = "Toggle Boolean",
  },
})

-- git
wk.add({
  {
    "<leader>gP",
    "<cmd>Gitsigns preview_hunk<CR>",
    desc = "Preview hunk",
  },
  {
    "<leader>gt",
    "<cmd>Gitsigns toggle_current_line_blame<CR>",
    desc = "Toggle line blame",
  },
})

-- terminal toggle
wk.add({
  {
    "<leader>t",
    function()
      Snacks.terminal.toggle(nil, {
        cwd = vim.fn.getcwd(),
      })
    end,
    desc = "Toggle CWD Terminal",
  },
})

-- }}}
