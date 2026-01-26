return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      "saghen/blink.cmp",
      ft = "lua",
      opts = {},
    },
    config = function()
      local lspconfig = require("lspconfig")
      -- local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Lua
      lspconfig.lua_ls.setup({
        -- capabilities = capabilities, -- Pass capabilities to every setu
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Clang
      lspconfig.clangd.setup({
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
        },
      })

      -- Python
      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic",
            },
          },
        },
      })

      -- Bash
      lspconfig.bashls.setup({
        filetypes = { "sh", "bash", "zsh" },
      })

      -- Fish
      lspconfig.fish_lsp.setup({
        filetypes = { "fish" },
      })

      lspconfig.cssls.setup({
        settings = {},
      })
    end,
  },
}
