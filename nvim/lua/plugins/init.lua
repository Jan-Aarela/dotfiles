return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    enabled = false,
    lazy = true,
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "alanfortlink/blackjack.nvim",
    lazy = false,
  },

  {
    "seandewar/nvimesweeper",
    lazy = false,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
  },

  {
    "mbbill/undotree",
    lazy = false,
  },

  {
    "eandrju/cellular-automaton.nvim",
    lazy = false,
  },

  {
    "makaze/AnsiEsc",
    lazy = false,
    cmd = { "AnsiEsc" },
  },

  {
    "dalance/svls",
    default_config = {
      cmd = { "svls" },
      filetypes = { "verilog", "systemverilog" },
      root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
      end,
    },
    docs = {
      description = [[
      https://github.com/dalance/svls

      Language server for verilog and SystemVerilog

      `svls` can be installed via `cargo`:
      ```sh
      cargo install svls
      ```
      ]],
    },
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require "configs.colorizer"
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "json",
        "jsonc",
      },
      highlight = {
        enable = true,
      },
      auto_install = true,
    },
  },
}
