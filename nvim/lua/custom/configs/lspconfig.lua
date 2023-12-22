local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        enable = true,
        command = "clippy",
        features = "all",
      },
    }
  }
})
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"}
})

lspconfig.r_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"r", "rmd"},
  cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
})

-- Register linters and formatters per language
local ruff = require('efmls-configs.linters.ruff')
local black = require('efmls-configs.formatters.black')
local rustfmt = require('efmls-configs.formatters.rustfmt')
local languages = {
  python = {ruff, black},
  rust = {rustfmt}
}

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require('efmls-configs.defaults').languages()

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

lspconfig.efm.setup(vim.tbl_extend('force', efmls_config, {
  -- Pass your custom lsp config below like on_attach and capabilities
  --
  -- on_attach = on_attach,
  -- capabilities = capabilities,
}))

--Enable (broadcasting) snippet capability for completion
local hcapabilities = vim.lsp.protocol.make_client_capabilities()
hcapabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = hcapabilities,
}
