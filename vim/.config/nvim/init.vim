" reference: https://dougblack.io/words/a-good-vimrc.html

call plug#begin('~/.vim/plugged')

" Plugins

" Language {
    Plug 'chrisbra/csv.vim', { 'commit': '9ab092187a7046a8d0eedc7fbbce8fac38d10563' }
    Plug 'editorconfig/editorconfig-vim', { 'commit': '3078cd10b28904e57d878c0d0dab42aa0a9fdc89' }
    Plug 'elzr/vim-json', { 'commit': '3727f089410e23ae113be6222e8a08dd2613ecf2' }

    Plug 'fatih/vim-go', { 'commit': 'a319aaf6bf652dadb197807e4629ff5b1750a17b' }
    let g:go_list_type='quickfix'
    let g:syntastic_go_checkers=['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map={ 'mode': 'active', 'passive_filetypes': ['go'] }

    Plug 'mattn/emmet-vim', { 'commit': 'def5d57a1ae5afb1b96ebe83c4652d1c03640f4d' }
    Plug 'mboughaba/i3config.vim', { 'commit': '5c753c56c033d3b17e5005a67cdb9653bbb88ba7' }

    Plug 'mxw/vim-jsx', { 'commit': '8879e0d9c5ba0e04ecbede1c89f63b7a0efa24af' }
    let g:jsx_ext_required=0

    Plug 'plasticboy/vim-markdown', { 'commit': '8e5d86f7b85234d3d1b4207dceebc43a768ed5d4' }
    let g:markdown_fenced_languages=['bash=sh', 'css', 'elixir', 'html', 'javascript', 'json', 'jsx', 'python', 'ruby', 'yaml']
    let g:vim_markdown_conceal=0

    Plug 'scrooloose/nerdcommenter', { 'commit': '9fffd4c022da39a324a2eee2a0939db66db7c553' }

    " A solid language pack for Vim.
    Plug 'sheerun/vim-polyglot', { 'commit': 'c96947b1c64c56f70125a9bac9c006f69e45d5d3' }
    let g:polyglot_disabled=['json', 'markdown']

    " ragtag.vim: ghetto HTML/XML mappings (formerly allml.vim)
    Plug 'tpope/vim-ragtag', { 'commit': 'b8966c4f6503a8baaec39e17bd0bf38b2aadc9b2' }

    Plug 'tpope/vim-rails', { 'commit': '3bac0233a49d2a00805c66bf17d3e2ea114b05d1' }

    Plug 'vim-syntastic/syntastic', { 'commit': '2c4b33f6e6679fb5f3824d9cd38d4813c71a19a3' }
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
    let g:syntastic_javascript_checkers=['eslint']
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_python_python_exec='/usr/local/bin/python3'
" }

" ## Completion {
    " A code-completion engine for Vim
    Plug 'ycm-core/YouCompleteMe', { 'commit': 'c0e82e91a4ca780dad67f7bb8f6067a1cc11f580' }

    " endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc
    Plug 'tpope/vim-endwise', { 'commit': '4289889a2622f9bc7c594a6dd79763781f63dfb5' }
" }

" Code Display {
    " A vim plugin to display the indention levels with thin vertical lines
    Plug 'Yggdroot/indentLine', { 'commit': '5617a1cf7d315e6e6f84d825c85e3b669d220bfa' }

    Plug 'vim-airline/vim-airline', { 'commit': '332d44948a3c737272172d0eae0bf5b940e72459' }
    Plug 'vim-airline/vim-airline-themes', { 'commit': '97cf3e6e638f936187d5f6e9b5eb1bdf0a4df256' }
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_symbols_ascii = 1

    " A Vim plugin to colorize all text in the form #rrggbb or #rgb.
    Plug 'chrisbra/Colorizer', { 'commit': '826d5691ac7d36589591314621047b1b9d89ed34' }
" }

" Integrations {
    " A Vim plugin which shows a git diff in the sign column.
    Plug 'airblade/vim-gitgutter', { 'commit': '256702dd1432894b3607d3de6cd660863b331818' }

    " Run your tests at the speed of thought
    Plug 'janko-m/vim-test', { 'commit': 'c44be6765edb81834797e66ad206f83e190bdd49' }

    " fugitive.vim: A Git wrapper so awesome, it should be illegal
    Plug 'tpope/vim-fugitive', { 'commit': 'b1c3cdffc94c2cbe48777db5cf8bc9156b17d070' }
" }

" Interface {
    " fzf :heart: vim
    Plug 'junegunn/fzf', { 'commit': '9cb7a364a31bdb882d873807774bdcf6fad0c9e4' }
    Plug 'junegunn/fzf.vim', { 'commit': 'd6aa21476b2854694e6aa7b0941b8992a906c5ec' }
" }

" Commands {
    " A Narrow Region Plugin for vim (like Emacs Narrow Region)
    Plug 'chrisbra/NrrwRgn', { 'commit': 'be7f06308bddd493d436372ee71d6b366af97fbb' }

    Plug 'easymotion/vim-easymotion', { 'commit': 'd75d9591e415652b25d9e0a3669355550325263d' }

    Plug 'ntpeters/vim-better-whitespace', { 'commit': 'c5afbe91d29c5e3be81d5125ddcdc276fd1f1322' }
    Plug 'terryma/vim-multiple-cursors', { 'commit': '6456718e1d30b42c04b920c5413ca44f68f08759' }
    Plug 'tpope/vim-repeat', { 'commit': '24afe922e6a05891756ecf331f39a1f6743d3d5a' }
    Plug 'tpope/vim-surround', { 'commit': 'aeb933272e72617f7c4d35e1f003be16836b948d' }
    Plug 'tpope/vim-unimpaired', { 'commit': 'e4006d68cd4f390efef935bc09be0ce3bd022e72' }

    " Vim plugin that provides additional text objects
    Plug 'wellle/targets.vim', { 'commit': '8d6ff2984cdfaebe5b7a6eee8f226a6dd1226f2d' }
" }

" Other {
" }

" Uncategorized {
    Plug 'AndrewRadev/splitjoin.vim', { 'commit': '0f45bfd7d6a8acb7d6ac126001a27190851bf3f5' }

    " Plugin for vim to enabling opening a file in a given line
    Plug 'bogado/file-line', { 'commit': '559088afaf10124ea663ee0f4f73b1de48fb1632' }

    " Rainbow Parentheses Improved, shorter code, no level limit, smooth and
    " fast, powerful configuration.
    Plug 'luochen1990/rainbow', { 'commit': 'c18071e5c7790928b763c2e88c487dfc93d84a15' }
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
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>p :Files<CR>
    nnoremap <leader>q :q<CR>
    nnoremap <leader>r zR
    nnoremap <leader>ga :Gwrite<CR>
    nnoremap <leader>gc :G commit<CR>
    nnoremap <leader>gd :G diff<CR>
    nnoremap <leader>gdc :G diff --cached<CR>
    nnoremap <leader>gl :G log --oneline --decorate<CR>
    nnoremap <leader>gp :G push<CR>
    nnoremap <leader>gs :G status<CR>

    " How to toggle Vim's search highlight visibility without disabling it
    " ref: https://stackoverflow.com/a/26504944
    nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

    " map <Esc> to exit terminal-mode
    " ref: https://neovim.io/doc/user/nvim_terminal_emulator.html
    if has('nvim')
        tnoremap <Esc> <C-\><C-n>
    endif

    " bind K to grep word under cursor
    " ref: https://thoughtbot.com/blog/faster-grepping-in-vim
    nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" }

" Theme {
" }

    " vim: set foldmarker={,}:
