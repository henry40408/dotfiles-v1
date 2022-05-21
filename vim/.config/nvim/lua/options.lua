local c = vim.cmd
local o = vim.opt

-- Using the mouse for Vim in an xterm
-- ref: https://vim.fandom.com/wiki/Using_the_mouse_for_Vim_in_an_xterm
o.mouse = 'a'

-- Result in spaces being used for all indentation
-- ref: https://vim.fandom.com/wiki/Indenting_source_code
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4

-- Does nothing more than copy the indentation from the previous line, when starting a new line
-- ref: https://vim.fandom.com/wiki/Indenting_source_code
o.autoindent = true

-- Make backspace work like most other programs
-- ref: https://vim.fandom.com/wiki/Backspace_and_delete_problems#Backspace_key_won.27t_move_from_current_line
o.backspace = 'indent,eol,start'

-- Highlighting that moves with the cursor
-- ref: https://vim.fandom.com/wiki/Highlight_current_line
o.laststatus = 2
o.cursorline = true
o.number = true
-- ref: https://github.com/neovim/neovim/issues/18160
c([[highlight CursorLine guibg=#111111]])

-- By setting the option 'hidden', you can load a buffer in a window that currently has a modified buffer
-- ref: http://vimdoc.sourceforge.net/htmldoc/options.html#'hidden'
o.hidden = true

-- Case sensitivity
-- ref: https://vim.fandom.com/wiki/Searching#Case_sensitivity
o.ignorecase = true
o.smartcase = true

-- Show the next match while entering a search
-- ref: https://vim.fandom.com/wiki/Searching#Show_the_next_match_while_entering_a_search
o.incsearch = true

-- What do you use for your listchars?
-- ref: https://www.reddit.com/r/vim/comments/4hoa6e/comment/d2ra7qh/
o.list = true
o.listchars = {
  eol = '⤶',
  extends = '›',
  nbsp = '·',
  precedes = '‹',
  tab = '» ',
  trail = '·',
}

-- Vim highlights the remaining matches with the Search highlight group
-- ref: https://vim.fandom.com/wiki/Search_and_replace#Basic_search_and_replace
o.hlsearch = true

-- Does not change the text but simply displays it on multiple lines
-- ref: https://vim.fandom.com/wiki/Automatic_word_wrapping
o.wrap = true

-- With custom background highlight
-- ref: https://github.com/lukas-reineke/indent-blankline.nvim/tree/8567ac8ccd19ee41a6ec55bf044884799fa3f56b
o.termguicolors = true
c([[
highlight IndentBlanklineIndent1 guibg=#121212 gui=nocombine
highlight IndentBlanklineIndent2 guibg=#212121 gui=nocombine
]])
