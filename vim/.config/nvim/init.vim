" reference: https://dougblack.io/words/a-good-vimrc.html

call plug#begin('~/.vim/plugged')

" Plugins

" Language {
    Plug 'chrisbra/csv.vim', { 'commit': '9ab0921' }
    Plug 'editorconfig/editorconfig-vim', { 'commit': '3078cd1' }
    Plug 'elzr/vim-json', { 'commit': '3727f08' }

    Plug 'fatih/vim-go', { 'commit': 'a319aaf' }
    let g:go_list_type='quickfix'
    let g:syntastic_go_checkers=['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map={ 'mode': 'active', 'passive_filetypes': ['go'] }

    Plug 'mattn/emmet-vim', { 'commit': 'def5d57' }
    Plug 'mboughaba/i3config.vim', { 'commit': '5c753c5' }

    Plug 'mxw/vim-jsx', { 'commit': '8879e0d' }
    let g:jsx_ext_required=0

    Plug 'plasticboy/vim-markdown', { 'commit': '8e5d86f' }
    let g:markdown_fenced_languages=['bash=sh', 'css', 'elixir', 'html', 'javascript', 'json', 'jsx', 'python', 'ruby', 'yaml']
    let g:vim_markdown_conceal=0

    Plug 'scrooloose/nerdcommenter', { 'commit': '9fffd4c' }

    " A solid language pack for Vim.
    Plug 'sheerun/vim-polyglot', { 'commit': 'c96947b' }
    let g:polyglot_disabled=['json', 'markdown']

    " ragtag.vim: ghetto HTML/XML mappings (formerly allml.vim)
    Plug 'tpope/vim-ragtag', { 'commit': 'b8966c4' }

    Plug 'tpope/vim-rails', { 'commit': '3bac023' }

    Plug 'vim-syntastic/syntastic', { 'commit': '2c4b33f' }
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
    let g:syntastic_javascript_checkers=['eslint']
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_python_python_exec='/usr/local/bin/python3'
" }

" ## Completion {
    " endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc
    Plug 'tpope/vim-endwise', { 'commit': '4289889' }
" }

" Code Display {
    " A vim plugin to display the indention levels with thin vertical lines
    Plug 'Yggdroot/indentLine', { 'commit': '5617a1c' }

    Plug 'vim-airline/vim-airline', { 'commit': '332d449' }
    Plug 'vim-airline/vim-airline-themes', { 'commit': '97cf3e6' }
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_symbols_ascii = 1

    " A Vim plugin to colorize all text in the form #rrggbb or #rgb.
    Plug 'chrisbra/Colorizer', { 'commit': '826d569' }

    Plug 'kien/ctrlp.vim', { 'commit': '564176f' }
    let g:ctrlp_custom_ignore='\v[\/](\.(git|hg|svn)|(_build|deps|node_modules))$'
    let g:ctrlp_map='<leader>p'
    let g:ctrlp_working_path_mode='w'
" }

" Integrations {
    " A Vim plugin which shows a git diff in the sign column.
    Plug 'airblade/vim-gitgutter', { 'commit': '256702d' }

    " Run your tests at the speed of thought
    Plug 'janko-m/vim-test', { 'commit': 'c44be67' }

    " fugitive.vim: A Git wrapper so awesome, it should be illegal
    Plug 'tpope/vim-fugitive', { 'commit': 'b1c3cdf' }
" }

" Interface {
" }

" Commands {
    " A Narrow Region Plugin for vim (like Emacs Narrow Region)
    Plug 'chrisbra/NrrwRgn', { 'commit': 'be7f063' }

    Plug 'easymotion/vim-easymotion', { 'commit': 'd75d959' }
    Plug 'ntpeters/vim-better-whitespace', { 'commit': 'c5afbe9' }
    Plug 'terryma/vim-multiple-cursors', { 'commit': '6456718' }
    Plug 'tpope/vim-repeat', { 'commit': '24afe92' }
    Plug 'tpope/vim-surround', { 'commit': 'aeb9332' }
    Plug 'tpope/vim-unimpaired', { 'commit': 'e4006d6' }

    " Vim plugin that provides additional text objects
    Plug 'wellle/targets.vim', { 'commit': '8d6ff29' }
" }

" Other {
" }

" Uncategorized {
    Plug 'AndrewRadev/splitjoin.vim', { 'commit': '0f45bfd' }

    " Plugin for vim to enabling opening a file in a given line
    Plug 'bogado/file-line', { 'commit': '559088a' }

    " Rainbow Parentheses Improved, shorter code, no level limit, smooth and
    " fast, powerful configuration.
    Plug 'luochen1990/rainbow', { 'commit': 'c18071e' }
" }

call plug#end()

filetype plugin indent on
syntax on

" Configuration {
    " result in spaces being used for all indentation
    " ref: https://vim.fandom.com/wiki/Indenting_source_code
    set expandtab shiftwidth=4 tabstop=4

    " does nothing more than copy the indentation from the previous line, when starting a new line.
    " ref: https://vim.fandom.com/wiki/Indenting_source_code
    set autoindent

    " make backspace work like most other programs
    " ref: https://vim.fandom.com/wiki/Backspace_and_delete_problems#Backspace_key_won.27t_move_from_current_line
    set backspace=2

    " Highlighting that moves with the cursor
    " ref: https://vim.fandom.com/wiki/Highlight_current_line
    set cursorline laststatus=2 number
    highlight CursorLine cterm=NONE ctermbg=darkgrey

    " By setting the option 'hidden', you can load a buffer in a window that currently has a modified buffer.
    " ref: http://vimdoc.sourceforge.net/htmldoc/options.html#'hidden'
    set hidden

    " Case sensitivity
    " ref: https://vim.fandom.com/wiki/Searching#Case_sensitivity
    set ignorecase smartcase

    " Show the next match while entering a search
    " ref: https://vim.fandom.com/wiki/Searching#Show_the_next_match_while_entering_a_search
    set incsearch

    " Vim highlights the remaining matches with the Search highlight group.
    " ref: https://vim.fandom.com/wiki/Search_and_replace#Basic_search_and_replace
    set hlsearch

    " What do you use for your listchars?
    " ref: https://www.reddit.com/r/vim/comments/4hoa6e/comment/d2ra7qh/
    set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

    " does not change the text but simply displays it on multiple lines.
    " ref: https://vim.fandom.com/wiki/Automatic_word_wrapping
    set wrap

    " Treat words with dash as a word in Vim
    " ref: https://til.hashrocket.com/posts/t8osyzywau-treat-words-with-dash-as-a-word-in-vim
    augroup CssHtmlGroup
        autocmd!
        autocmd filetype css,html setlocal iskeyword+=-
    augroup END

    " shoves all those files into three directories, rather than individual local project directories
    " ref: https://sts10.github.io/2016/02/13/best-of-my-vimrc.html
    call system('mkdir -p ~/.vim/backup')
    call system('mkdir -p ~/.vim/swap')
    set backupdir=~/.vim/backup/
    set directory=~/.vim/swap/
    if has('persistent_undo')
        call system('mkdir -p ~/.vim/undo')
        set undodir=~/.vim/undo/ undofile undolevels=1000 undoreload=10000
    endif

    " use SPACE as mapleader
    " ref: https://stackoverflow.com/a/446293
    let mapleader=" "
    nnoremap <SPACE> <Nop>

    " Map semicolon to colon
    " ref: https://vim.fandom.com/wiki/Map_semicolon_to_colon
    vnoremap ; :
    nnoremap ; :

    " retain the visual selection after having pressed > or <
    " ref: https://vim.fandom.com/wiki/Shifting_blocks_visually#Mappings
    vnoremap > >gv
    vnoremap < <gv

    " my mappings
    nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
    nnoremap <silent> <leader>vs :so $MYVIMRC<CR>:echo 'Sourced!'<CR>
    nnoremap <leader>b :CtrlPBuffer<CR>
    nnoremap <leader>q :bdelete<CR>
    nnoremap <leader>r zR
    nnoremap <leader>ga :Gwrite<CR>
    nnoremap <leader>gc :G commit<CR>
    nnoremap <leader>gd :G diff<CR>
    nnoremap <leader>gdc :G diff --cached<CR>
    nnoremap <leader>gs :G status<CR>
    nnoremap <leader>gl :G log<CR>

    " How to toggle Vim's search highlight visibility without disabling it
    " ref: https://stackoverflow.com/a/26504944
    nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

    " map <Esc> to exit terminal-mode
    " ref: https://neovim.io/doc/user/nvim_terminal_emulator.html
    if has('nvim')
        tnoremap <Esc> <C-\><C-n>
    endif

    " The Silver Searcher
    " ref: https://robots.thoughtbot.com/faster-grepping-in-vim
    if executable('ag')
        " Use ag over grep
        set grepprg=ag\ --nogroup\ --nocolor

        " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
        let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching=0
    endif

    " bind K to grep word under cursor
    " ref: https://thoughtbot.com/blog/faster-grepping-in-vim
    nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" }

" Theme {
" }

" vim: set foldmarker={,}:
