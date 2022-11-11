require('mason-lspconfig').setup({
  ensure_installed = {
    'eslint',
    'jsonls',
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'taplo',
    'tflint',
    'tsserver',
    'yamlls',
  }
})
