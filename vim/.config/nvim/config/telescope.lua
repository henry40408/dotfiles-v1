local map_key = vim.keymap.set
require('telescope').setup()
map_key('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>fc', '<cmd>lua require("telescope.builtin").commands()<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>fs', '<cmd>lua require("telescope.builtin").colorscheme({ enable_preview = true })<CR>', { noremap = true, silent = true })
