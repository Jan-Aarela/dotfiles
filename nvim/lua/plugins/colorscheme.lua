-- vim:foldmethod=marker
return {
    -- Set colorscheme
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = vim.env.TERM == "linux" and "wildcharm" or "dracula",
        },
    },

    -- Catppuccin {{{
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            transparent_background = true,
            integrations = {
                nvimtree = true,
                telescope = true,
                which_key = true,
                noice = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
            },
        },
    },
    -- }}}

    -- Dracula {{{
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function(_, opts)
            require("dracula").setup(opts)
            vim.cmd([[colorscheme dracula]])
        end,
        opts = {
            transparent_bg = true,
            italic_comment = true,
        },
    },
    -- }}}

    -- Rose pine {{{
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            styles = {
                bold = true,
                italic = true,
                transparency = true, -- Rose Pine's native transparency
            },
            -- This function runs whenever rose-pine is loaded,
            -- but doesn't force it to be the active theme.
            highlight_groups = {
                Normal = { bg = "none" },
                NormalFloat = { bg = "none" },
                FloatBorder = { bg = "none" },
            },
        },
    },
    --}}}

    -- kanagawa {{{
    {
        "rebelot/kanagawa.nvim",
        opts = {
            transparent = true,
            overrides = function(colors)
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                }
            end,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                            bg_p1 = "none",
                        },
                    },
                },
            },
            integrations = {
                noice = true,
                telescope = true,
            },
        },
    },
}
-- }}}
