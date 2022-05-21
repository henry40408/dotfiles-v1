require('gitsigns').setup({
  signcolumn = true,
  current_line_blame = true,
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '▁' },
    topdelete = { text = '▔' },
    changedelete = { text = '░' },
  },
})
