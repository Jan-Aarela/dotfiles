return {
    {
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

            explorer = {
                replace_netrw = true,
                trash = true,
            },
            picker = {
                -- This reconfigures the structural layouts used by the pickers
                layouts = {
                    sidebar = {
                        layout = {
                            box = "horizontal",
                            width = 40,
                            position = "left",
                            {
                                box = "vertical",
                                border = "single", -- Forces standard square ASCII lines globally for sidebars
                                { win = "input", height = 1, border = "bottom" },
                                { win = "list", border = "none" },
                            },
                        },
                    },

                    default = {
                        layout = {
                            box = "vertical",
                            border = "single", -- Forces square ASCII borders on the main popup frame
                            width = 0.8,
                            min_width = 80,
                            height = 0.8,
                            min_height = 20,
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", border = "left", width = 0.5 },
                            },
                        },
                    },
                },
                sources = {
                    explorer = {
                        -- Tells the explorer to use our now-squared sidebar layout preset
                        layout = {
                            preset = "sidebar",
                        },
                        hidden = true,
                    },
                },
            },

            scroll = {
                enabled = true,
                animate = {
                    duration = { step = 5, total = 100 },
                    easing = "linear",
                },
                -- faster animation when repeating scroll after delay
                animate_repeat = {
                    delay = 100, -- delay in ms before using the repeat animation
                    duration = { step = 5, total = 50 },
                    easing = "linear",
                },
            },

            styles = {
                notification = { border = "single" },
                input = { border = "single" },
            },

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
                    border = "single", -- Use 'single', 'double', 'rounded', 'solid', or an array of characters
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
                        corner_top = "┌",
                        corner_bottom = "└",
                        -- corner_top = "╭",
                        -- corner_bottom = "╰",
                        horizontal = "─",
                        vertical = "│",
                        arrow = ">",
                    },
                },
            },
        },
    },

    {
        "folke/noice.nvim",
        opts = {
            presets = {
                lsp_doc_border = true,
            },
        },
    },

    {
        "folke/which-key.nvim",
        opts = {
            win = {
                border = "single", -- Force square border on the pop-up panel
            },
        },
    },
}
