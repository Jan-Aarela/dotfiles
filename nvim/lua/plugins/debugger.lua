return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mason-org/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "leoluz/nvim-dap-go",
    },
    keys = {
        {
            "<F5>",
            function()
                require("dap").continue()
            end,
            desc = "Debug: Start/Continue",
        },
        {
            "<F1>",
            function()
                require("dap").step_into()
            end,
            desc = "Debug: Step Into",
        },
        {
            "<F2>",
            function()
                require("dap").step_over()
            end,
            desc = "Debug: Step Over",
        },
        {
            "<F3>",
            function()
                require("dap").step_out()
            end,
            desc = "Debug: Step Out",
        },
        {
            "<leader>b",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Debug: Toggle Breakpoint",
        },
        {
            "<leader>B",
            function()
                require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end,
            desc = "Debug: Set Breakpoint",
        },
        {
            "<F7>",
            function()
                require("dapui").toggle()
            end,
            desc = "Debug: See last session result.",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
            automatic_installation = true,
            handlers = {},
            ensure_installed = { "delve" },
        })

        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
            controls = {
                icons = {
                    pause = "⏸",
                    play = "▶",
                    step_into = "⏎",
                    step_over = "⏭",
                    step_out = "⏮",
                    step_back = "b",
                    run_last = "▶▶",
                    terminate = "⏹",
                    disconnect = "⏏",
                },
            },
        })

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        require("dap-go").setup({
            delve = { detached = vim.fn.has("win32") == 0 },
        })

        -- ==============================
        -- AVR SPECIFIC CONFIG START
        -- ==============================

        -- dap.adapters.avr = {
        --     type = "executable",
        --     command = "avr-gdb",
        --     args = { "--interpreter=mi2" },
        -- }

        dap.adapters.gdb = {
            type = "executable",
            command = "avr-gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
        }

        -- dap.configurations.c = {
        --     {
        --         name = "Debug AVR",
        --         type = "avr",
        --         request = "launch",
        --         program = function()
        --             return vim.fn.input("Path to .elf file: ", vim.fn.getcwd() .. "/", "file")
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopOnEntry = true,
        --         -- This is the critical part:
        --         target = "localhost:1234",
        --         externalConsole = true,
        --         -- Adding this ensures GDB actually talks to the port
        --         setupCommands = {
        --             {
        --                 text = "-target-select remote localhost:1234",
        --                 description = "connect to gdbserver",
        --                 ignoreFailures = false,
        --             },
        --         },
        --     },
        -- }

        dap.configurations.c = {
            {
                name = "AVR Debug (simavr)",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to ELF: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = true,

                setupCommands = {
                    {
                        text = "target remote :1234",
                        description = "Connect to simavr",
                    },
                    {
                        text = "monitor reset",
                    },
                    {
                        text = "load",
                    },
                },
            },
        }

        -- link C++ to the same config if you're using .cpp files
        dap.configurations.cpp = dap.configurations.c

        -- ==============================
        -- AVR SPECIFIC CONFIG END
        -- ==============================
    end,
}
