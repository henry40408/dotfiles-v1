local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local map_key = vim.keymap.set
local lsp = require('lspconfig')

lsp.rust_analyzer.setup({
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      assist = {
        importGranularity = 'module',
        importPrefix = 'self',
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

lsp.tsserver.setup({
  capabilities = capabilities,
})

lsp.pylsp.setup({
  capabilities = capabilities,
})

--ref: https://sharksforarms.dev/posts/neovim-rust/
local opts = { noremap = true, silent = true }
map_key('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map_key('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
map_key('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map_key('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map_key('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
map_key('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map_key('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
map_key('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
map_key('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
