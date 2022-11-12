local sf = string.format
local source_cmd = sf('<cmd>source $MYVIMRC<CR><cmd>echo "sourced %s"<CR>', os.getenv('MYVIMRC'))

local wk = require('which-key')
wk.register({
  c = { '<cmd>close<CR>', 'Close window' },
  b = {
    name = 'Buffer',
    d = { '<cmd>bdelete<CR>', 'Close buffer' },
  },
  f = {
    name = 'Telescope',
    b = { '<cmd>Telescope buffers<CR>', 'Find buffers' },
    c = { '<cmd>Telescope commands<CR>', 'Find commands' },
    f = { '<cmd>Telescope find_files hidden=true<CR>', 'Find files (including hidden)' },
    g = { '<cmd>Telescope live_grep<CR>', 'Live grep' },
    h = { '<cmd>Telescope help_tags<CR>', 'Find documentation' },
    s = { '<cmd>Telescope colorscheme enable_preview=true<CR>', 'Find colorscheme' },
  },
  g = {
    name = 'Git',
    s = { '<cmd>Git<CR>', 'Git status' },
  },
  h = { '<cmd>nohls<CR>', 'Clean search highlight' },
  l = {
    name = 'LSP',
    f = { '<cmd>lua vim.lsp.buf.format()<CR>', 'LSP Format' },
    i = { '<cmd>LspInfo<CR>', 'LSP Info' },
  },
  p = {
    c = { '<cmd>PackerCompile<CR>', 'Packer compile' },
    s = { '<cmd>PackerSync<CR>', 'Packer synchronize' },
  },
  q = { '<cmd>quit<CR>', 'Quit' },
  v = {
    name = 'Configuration',
    e = { '<cmd>edit $MYVIMRC<CR>', 'Edit configuration' },
    s = { source_cmd, 'Reload configuration' },
  },
  z = {
    name = 'Zoom',
    z = { '<cmd>call zoomwintab#Toggle()<CR>', 'Toggle zoom win tab' }
  }
}, { prefix = '<leader>' })
