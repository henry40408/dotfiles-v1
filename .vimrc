" reference: https://dougblack.io/words/a-good-vimrc.html

call plug#begin('~/.vim/plugged')

Plug 'Shougo/dein.vim'

" Plugins

" Language {
    Plug 'chrisbra/csv.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'elzr/vim-json'

    Plug 'fatih/vim-go'
    let g:syntastic_go_checkers=['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map={ 'mode': 'active', 'passive_filetypes': ['go'] }
    let g:go_list_type='quickfix'

    Plug 'marijnh/tern_for_vim'
    Plug 'mattn/emmet-vim'

    Plug 'mxw/vim-jsx'
    let g:jsx_ext_required=0

    Plug 'plasticboy/vim-markdown'
    let g:markdown_fenced_languages=['bash=sh', 'css', 'elixir', 'html', 'javascript', 'json', 'jsx', 'python', 'ruby', 'yaml']
    let g:vim_markdown_conceal=0

    Plug 'scrooloose/nerdcommenter'

    Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled=['json', 'markdown']

    Plug 'suan/vim-instant-markdown'
    Plug 'tpope/vim-ragtag'
    Plug 'tpope/vim-rails'

    Plug 'scrooloose/syntastic'
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
    let g:syntastic_python_checkers=['flake8']
    let g:syntastic_python_python_exec='/usr/local/bin/python3'
" }

" ## Completion {
    Plug 'Raimondi/delimitMate'
    let g:delimitMate_expand_cr=1

    Plug 'Valloric/YouCompleteMe'
    let g:ycm_python_binary_path='/usr/local/bin/python'
    " turn on semantic trigger but identifier trigger
    let g:ycm_min_num_of_chars_for_completion=1024

    Plug 'tpope/vim-endwise'
" }

" Code Display {
    Plug 'Yggdroot/indentLine'

    Plug 'bling/vim-airline'
    let g:airline#extensions#tabline#enabled=1
    let g:airline_powerline_fonts=1

    Plug 'chrisbra/Colorizer'
    Plug 'chriskempson/vim-tomorrow-theme'

    Plug 'kien/ctrlp.vim'
    let g:ctrlp_custom_ignore='\v[\/](\.(git|hg|svn)|(_build|deps|node_modules))$'
    let g:ctrlp_map='<leader>p'
    let g:ctrlp_working_path_mode='w'

    Plug 'dracula/vim', { 'as': 'dracula' }
" }

" Integrations {
    Plug 'gregsexton/gitv'
    Plug 'janko-m/vim-test'
    Plug 'mhinz/vim-signify'

    Plug 'skwp/greplace.vim'
    let g:grep_cmd_opts='--noheading'

    Plug 'tpope/vim-fugitive'
" }

" Interface {
    Plug 'altercation/vim-colors-solarized'
    let g:solarized_termcolors=256

    Plug 'mbbill/undotree'
    Plug 'sjl/gundo.vim'
" }

" Commands {
    Plug 'chrisbra/NrrwRgn'

    Plug 'keith/investigate.vim'
    let g:investigate_use_dash=1

    Plug 'ntpeters/vim-better-whitespace'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'wellle/targets.vim'
" }

" Other {
    Plug 'tmux-plugins/vim-tmux'
" }

" Uncategorized {
    Plug 'AndrewRadev/splitjoin.vim'

    Plug 'bogado/file-line'
    Plug 'luochen1990/rainbow'

    "Plug 'mtscout6/syntastic-local-eslint.vim'
    let g:syntastic_javascript_checkers=['jshint']
    let g:syntastic_javascript_eslint_exec='./node_modules/.bin/eslint'

    Plug 'muz/vim-gemfile'
    Plug 'rhysd/conflict-marker.vim'
    Plug 'shutnik/jshint2.vim'
    Plug 'slashmili/alchemist.vim'
    Plug 'terryma/vim-smooth-scroll'
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
