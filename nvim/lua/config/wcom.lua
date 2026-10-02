vim.api.nvim_create_user_command("Wcom", function(opts)
    local text = opts.args

    -- Run system toilet with smbraille font and border filter
    local output = vim.fn.systemlist({ "toilet", "-f", "smbraille", "--filter", "border", text })

    if vim.v.shell_error ~= 0 then
        vim.notify("toilet failed to run. Is toilet installed?", vim.log.levels.ERROR)
        return
    end

    -- Trim trailing empty/blank lines off the output
    while #output > 0 and output[#output]:match("^%s*$") do
        table.remove(output)
    end

    -- Get buffer's commentstring (e.g. "-- %s", "// %s", "# %s")
    local cs = vim.bo.commentstring
    if cs == "" or not cs:find("%%s") then
        cs = "-- %s"
    end

    -- Force exactly one space after the comment symbol before %s
    cs = cs:gsub("%s*%%s", " %%s")

    -- Comment out each line
    local commented_output = {}
    for _, line in ipairs(output) do
        table.insert(commented_output, string.format(cs, line))
    end

    -- Insert lines right under current cursor position
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row, row, false, commented_output)
end, { nargs = "+" })
