local map_key = vim.keymap.set
require('telescope').setup({
  defaults = {
    layout_config = {
      horizontal = {
        preview_width = 0.6,
        width = 0.99,
      },
    },
  },
  pickers = {
    buffers = {
      theme = 'dropdown',
      previewer = false,
    },
  },
})

local opts = { noremap = true, silent = true }
map_key('n', '<Leader>fb', '<cmd>Telescope buffers<CR>', opts)
map_key('n', '<Leader>fc', '<cmd>Telescope commands<CR>', opts)
map_key('n', '<Leader>ff', '<cmd>Telescope find_files<CR>', opts)
map_key('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map_key('n', '<Leader>fh', '<cmd>Telescope help_tags<CR>', opts)
map_key('n', '<Leader>fs', '<cmd>Telescope colorscheme enable_preview=true<CR>', opts)
