return {
  "stevearc/conform.nvim",

  opts = {
    formatters_by_ft = {
      -- Use Prettier for Javascript and CSS
      javascript = { "prettier" },
      typescript = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      -- c = { "clang-format" },

      -- Use Black for Python
      python = { "black" },

      -- You can list multiple formatters; the first one that runs successfully will be used
      lua = { "stylua" },

      -- Override or add formatters for filetypes that might have dot-separated names
      ["yaml.ansible"] = { "yamlfmt" },
    },
  },
}
