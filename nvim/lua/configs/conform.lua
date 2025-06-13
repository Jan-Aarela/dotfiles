require("conform").setup {
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = false,
  },

  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    css = { "prettier" },
    go = { "gofmt" },
    sh = { "beautysh", "trim_newlines" },
    bash = { "beautysh", "trim_newlines" },
    fish = { "fish_indent" },
  },

  formatters = {
    prettier = {
      prepend_args = { "--trailing-comma", "none" },
    },
  },
}
