require ("nvui.statusline") -- base config

local function custom_mode()
  local mode = vim.fn.mode()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    R = "REPLACE",
  }
  return modes[mode] or mode
end

-- Example: Add your custom mode at the start
stl[1] = function()
  return "%#St_normal# " .. custom_mode() .. " "
end

return statusline
