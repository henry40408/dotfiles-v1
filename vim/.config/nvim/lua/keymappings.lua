local sf = string.format
local map_key = vim.keymap.set

-- Map semicolon to colon
-- ref: https://vim.fandom.com/wiki/Map_semicolon_to_colon
map_key('n', ';', ':', {})
map_key('v', ';', ':', {})

-- Retain the visual selection after having pressed > or <
-- ref: https://vim.fandom.com/wiki/Shifting_blocks_visually#Mappings
map_key('v', '>', '>gv', { noremap = true })
map_key('v', '<', '<gv', { noremap = true })

-- My mappings
map_key('n', '<Leader>c', '<cmd>close<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>q', '<cmd>q<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>r', '<cmd>zR<CR>', { noremap = true, silent = true })
map_key('n', '<Leader>ve', '<cmd>e $MYVIMRC<CR>', { noremap = true, silent = true })
local c = sf('<cmd>so $MYVIMRC<CR><cmd>PackerCompile<CR><cmd>echo "sourced %s"<CR>', os.getenv('MYVIMRC'))
map_key('n', '<Leader>vs', c, { noremap = true, silent = true })

-- map <Esc> to exit terminal-mode
-- ref: https://neovim.io/doc/user/nvim_terminal_emulator.html
map_key('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
