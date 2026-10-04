return {
    "stevearc/conform.nvim",

    opts = {
        formatters_by_ft = {
            -- Prettier
            javascript = { "prettier" },
            typescript = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            yaml = { "prettier" },
            yml = { "prettier" },
            markdown = { "prettier" },
            toml = { "taplo" },
            xml = { "xmlformatter" },

            -- c family
            c = { "clang-format" },
            cpp = { "clang-format" },
            objc = { "clang-format" },
            objcpp = { "clang-format" },
            cuda = { "clang-format" },

            -- Build
            cmake = { "cmake_format" },

            -- Shell
            sh = { "shfmt" },
            bash = { "shfmt" },

            -- Rest
            python = { "black" },
            lua = { "stylua" },
            asm = { "asmfmt" },
        },

        formatters = {
            prettier = {
                prepend_args = { "--tab-width", "4", "--trailing-comma", "none" },
            },

            stylua = {
                prepend_args = { "--indent-width", "4", "--indent-type", "Spaces" },
            },

            shfmt = {
                prepend_args = { "-i", "4", "-ci" },
            },

            mbake = {
                command = "mbake",
                args = { "format", "$FILENAME" }, -- adjust args if your mbake version takes different flags
            },

            -- clang_format = {
            --     -- This tells clang-format to use 4 spaces and ignore local config files
            --     prepend_args = { "--style={IndentWidth: 4, TabWidth: 4, UseTab: Never}" },
            -- },
        },
    },
}
