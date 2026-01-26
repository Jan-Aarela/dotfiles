return {
  "saghen/blink.cmp",
  -- { "saghen/blink.cmp", enabled = false },

  -- other configuration like version, build, etc.
  opts = {
    completion = {
      menu = { border = "rounded" },
      documentation = { window = { border = "rounded" } },
    },

    -- signature = { window = { border = "rounded" } },

    keymap = {
      -- This sets a base set of keymaps. You can change this to 'enter' or 'supertab'
      -- but for custom keys, 'default' is a good starting point.
      preset = "default",

      -- TAB: Go to next item, jump forward in a snippet, or fallback to an actual <Tab>
      ["<Tab>"] = {
        "select_next", -- 1. Select the next item in the completion menu
        "snippet_forward", -- 2. Jump to the next placeholder in a snippet
        "fallback", -- 3. If none of the above, insert a literal <Tab>
      },
      -- SHIFT+TAB: Go to previous item, or jump backward in a snippet
      ["<S-Tab>"] = {
        "select_prev", -- 1. Select the previous item in the completion menu
        "snippet_backward", -- 2. Jump to the previous placeholder in a snippet
        "fallback", -- 3. Fallback to default <S-Tab> action
      },

      -- ENTER: Accept the completion/snippet or fallback to a newline
      ["<CR>"] = {
        "accept", -- Accept the selected item/snippet
        "fallback", -- If menu is closed, insert a newline
      },

      -- ESC: Hide the completion menu (without exiting insert mode) or fallback to <Esc>
      ["<Esc>"] = {
        "fallback",
      },

      ["<Down>"] = {
        "fallback", -- This means it will fall back to the default <Down> which is usually fine if you still want the cursor to move
      },
      ["<Up>"] = {
        "fallback", -- Same here for <Up>
      },

      -- You can also rebind the confirm key if you don't like <CR>
      -- ['<C-y>'] = { 'accept', 'fallback' },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          kind = "LSP",
          score_offset = 1000,
        },
      },
    },
  },
}
