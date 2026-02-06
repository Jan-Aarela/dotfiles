return {
    "snacks.nvim",
    ---@type snacks.Config

    init = function()
        vim.api.nvim_create_autocmd("ColorScheme", {
            desc = "Make indent lines match the parent text color",
            callback = function()
                vim.api.nvim_set_hl(0, "SnacksIndentChunk", { link = "Tag" })
                vim.api.nvim_set_hl(0, "SnacksIndentScope", { link = "Tag" })
            end,
        })
    end,

    opts = {
        scroll = { enabled = false },
        notifier = {
            enabled = true,
            timeout = 4000,
        },

        terminal = {
            win = {
                style = "float",
                relative = "editor",
                width = 0.75,
                height = 0.75,
                border = "rounded", -- Use 'single', 'double', 'rounded', 'solid', or an array of characters
            },
        },

        indent = {
            enabled = true,
            priority = 1,

            indent = {
                enabled = false,
                char = "│",
            },

            scope = {
                enabled = true, -- enable highlighting the current scope
                priority = 200,
                char = "│",
                underline = false, -- underline the start of the scope
                only_current = false, -- only show scope in the current window
                hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
            },

            chunk = {
                enabled = true,
                -- only show chunk scopes in the current window
                only_current = false,
                priority = 200,
                hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes

                char = {
                    -- corner_top = "┌",
                    -- corner_bottom = "└",
                    corner_top = "╭",
                    corner_bottom = "╰",
                    horizontal = "─",
                    vertical = "│",
                    arrow = ">",
                },
            },
        },
    },
}
