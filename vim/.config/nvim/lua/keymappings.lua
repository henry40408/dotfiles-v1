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
