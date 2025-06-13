-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "pyright", "hyprls", "rust_analyzer", "svls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Vitun härskä system verilog
-- lspconfig.svlangserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--
--   -- Root directory setup
--   root_dir = function(fname)
--     return require("lspconfig.util").find_git_ancestor(fname)
--   end,
--   cmd = { "svlangserver" },
--   filetypes = { "verilog", "systemverilog" },
--   settings = {
--     includeIndexing = {"**/*.{sv,svh}"},
--     excludeIndexing = {"test/**/*.sv*"},
--     defines = {},
--     formatCommand = "/tools/verible-verilog-format"
--     },
-- }

--
-- -- Clangd server
-- lspconfig.clangd.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
