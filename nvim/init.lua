-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[
function OpenMarkdownPreview (url)
  execute "silent ! chromium --new-window --app=" . a:url
endfunction
]])

vim.g.mkdp_browserfunc = "OpenMarkdownPreview"

vim.api.nvim_create_user_command("Calc", 'lua require("calculator").calculate()', { ["range"] = 1, ["nargs"] = 0 })
vim.api.nvim_create_user_command("Q", "q", {})

vim.diagnostic.config({
  virtual_text = true, -- This puts the error message right on the line
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})
