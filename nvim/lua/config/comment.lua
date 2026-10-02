vim.api.nvim_create_user_command("Lcom", function(opts)
    local line = opts.args
    local cs = vim.bo.commentstring

    -- Fallback to '#' if commentstring isn't set for the current buffer
    if cs == "" then
        cs = "# %s"
    end

    local divider_char = "="
    local raw_divider = string.rep(divider_char, 60)
    local divider = string.format(cs, raw_divider)

    local current_row = vim.api.nvim_win_get_cursor(0)[1]

    if line == "" then
        -- No args: insert just a single divider line
        vim.api.nvim_buf_set_lines(0, current_row - 1, current_row, false, { divider })
    else
        -- Args provided: insert framed comment block
        local comment = string.format(cs, line)
        vim.api.nvim_buf_set_lines(0, current_row - 1, current_row, false, {
            divider,
            comment,
            divider,
        })
    end
end, { nargs = "*" })
