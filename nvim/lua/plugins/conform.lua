return {
  "stevearc/conform.nvim",

  opts = {
    formatters_by_ft = {
      -- Prettier
      javascript = { "prettier" },
      typescript = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },

      -- c family
      c = { "clang-format" },
      cpp = { "clang-format" },
      objc = { "clang-format" },
      objcpp = { "clang-format" },
      cuda = { "clang-format" },

      -- Rest
      python = { "black" },
      lua = { "stylua" },

      ["yaml.ansible"] = { "yamlfmt" },
    },
  },
}
