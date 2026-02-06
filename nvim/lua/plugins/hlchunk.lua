return {
    "shellRaining/hlchunk.nvim",
    -- { "shellRaining/hlchunk.nvim", enabled = false },

    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("hlchunk").setup({

            chunk = {
                enable = false,
                delay = 100,
                use_treesitter = false,
            },

            indent = {
                enable = true,
                use_treesitter = false,
                chars = {
                    "│",
                    "╎",
                    "┆",
                    "┊",
                },
            },

            line_num = {
                enable = false,
            },
        })
    end,
}
