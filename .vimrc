" reference: https://dougblack.io/words/a-good-vimrc.html

call plug#begin('~/.vim/plugged')

Plug 'Shougo/dein.vim'

" Plugins

" Language {
    Plug 'chrisbra/csv.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'elzr/vim-json'

    Plug 'fatih/vim-go'
    let g:go_list_type='quickfix'
    let g:syntastic_go_checkers=['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map={ 'mode': 'active', 'passive_filetypes': ['go'] }

    Plug 'marijnh/tern_for_vim'
    Plug 'mattn/emmet-vim'

    Plug 'mxw/vim-jsx'
    let g:jsx_ext_required=0

    Plug 'plasticboy/vim-markdown'
    let g:markdown_fenced_languages=['bash=sh', 'css', 'elixir', 'html', 'javascript', 'json', 'jsx', 'python', 'ruby', 'yaml']
    let g:vim_markdown_conceal=0

    Plug 'scrooloose/nerdcommenter'

    " A solid language pack for Vim.
    Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled=['json', 'markdown']

    Plug 'suan/vim-instant-markdown'

    " ragtag.vim: ghetto HTML/XML mappings (formerly allml.vim)
    Plug 'tpope/vim-ragtag'

    Plug 'tpope/vim-rails'

    Plug 'vim-syntastic/syntastic'
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
    Plug 'tpope/vim-endwise'
" }

" Code Display {
    " A vim plugin to display the indention levels with thin vertical lines
    Plug 'Yggdroot/indentLine'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline#extensions#tabline#enabled = 1

    " A Vim plugin to colorize all text in the form #rrggbb or #rgb.
    Plug 'chrisbra/Colorizer'

    Plug 'kien/ctrlp.vim'
    let g:ctrlp_custom_ignore='\v[\/](\.(git|hg|svn)|(_build|deps|node_modules))$'
    let g:ctrlp_map='<leader>p'
    let g:ctrlp_working_path_mode='w'

    Plug 'dracula/vim', { 'as': 'dracula' }
" }

" Integrations {
    " Run your tests at the speed of thought
    Plug 'janko-m/vim-test'

    " ➕ Show a diff using Vim its sign column.
    Plug 'mhinz/vim-signify'

    " fugitive.vim: A Git wrapper so awesome, it should be illegal
    Plug 'tpope/vim-fugitive'
" }

" Interface {
    Plug 'mbbill/undotree'
" }

" Commands {
    " A Narrow Region Plugin for vim (like Emacs Narrow Region)
    Plug 'chrisbra/NrrwRgn'

    Plug 'ntpeters/vim-better-whitespace'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'

    " Vim plugin that provides additional text objects
    Plug 'wellle/targets.vim'
" }

" Other {
" }

" Uncategorized {
    Plug 'AndrewRadev/splitjoin.vim'

    " Plugin for vim to enabling opening a file in a given line
    Plug 'bogado/file-line'

    " Rainbow Parentheses Improved, shorter code, no level limit, smooth and
    " fast, powerful configuration.
    Plug 'luochen1990/rainbow'
" }

call plug#end()

filetype plugin indent on
syntax on

" Configuration {
    " migrated from spacemacs ¯\_(ツ)_/¯
    let mapleader="\<Space>"

    set autoindent expandtab shiftwidth=4 tabstop=4
    set backspace=2
    set cursorline laststatus=2 number
    set hidden
    set ignorecase incsearch regexpengine=1 smartcase
    set nohlsearch
    set list listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
    set wrap

    augroup CssHtmlGroup
        autocmd!
        autocmd filetype css,html setlocal iskeyword+=-
    augroup END

    augroup GoGroup
        autocmd!
        autocmd BufWrite *.go GoFmt
        autocmd BufWrite *.go GoImports
    augroup END

    call system('mkdir -p ~/.vim/backup')
    call system('mkdir -p ~/.vim/swap')
    set backupdir=~/.vim/backup/
    set directory=~/.vim/swap/

    if has('persistent_undo')
        call system('mkdir -p ~/.vim/undo')
        set undodir=~/.vim/undo/ undofile undolevels=1000 undoreload=10000
    endif

    " # Key mappings
    noremap <silent> <C-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <C-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>

    vnoremap ; :
    vnoremap > >gv
    vnoremap < <gv

    nnoremap ; :
    nnoremap <silent> <leader>u :UndotreeToggle<CR>
    nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
    nnoremap <silent> <leader>vs :so $MYVIMRC<CR>
    nnoremap <leader>b :CtrlPBuffer<CR>
    nnoremap <leader>q :bdelete<CR>
    nnoremap <leader>r zR

    if has('nvim')
        tnoremap <Esc> <C-\><C-n>
    endif

    " # The Silver Searcher
    " reference: https://robots.thoughtbot.com/faster-grepping-in-vim
    if executable('ag')
        " Use ag over grep
        set grepprg=ag\ --nogroup\ --nocolor

        " Use ag in CtrlP for listing files. Lightning fast and respects
        " .gitignore
        let g:ctrlp_user_command='ag %s -l --nocolor -g ""'

        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching=0
    endif

    " bind K to grep word under cursor
    nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" }

" Theme {
    colorscheme dracula
" }

" Highlight over-length lines {
    set colorcolumn=80
    highlight ColorColumn ctermbg=7 guibg=lightgrey
" }

" vim: set foldmarker={,}:
