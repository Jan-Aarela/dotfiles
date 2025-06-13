-- vi:foldmethod=marker

local autocmd = vim.api.nvim_create_autocmd

-- Remove Undotree buffer tab {{{
autocmd("FileType", {
  pattern = "undotree",
  callback = function()
    vim.schedule(function()
      for i, buf in ipairs(vim.t.bufs) do
        if not vim.bo[buf].buflisted then
          vim.t.bufs = vim.list_slice(vim.t.bufs, 1, i - 1)
        end
      end
      vim.cmd.redrawtabline()
    end)
  end,
})
-- }}}

-- NvimTree & Undotree visibility switch {{{
vim.api.nvim_create_autocmd("FileType", {
  pattern = "undotree",
  callback = function()
    vim.cmd "vertical resize 40"
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.bo[buf].filetype
      if ft == "NvimTree" then
        vim.cmd "NvimTreeClose"
        break
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.bo[buf].filetype
      if ft == "undotree" then
        vim.cmd "UndotreeHide"
        break
      end
    end
  end,
})
-- }}}
