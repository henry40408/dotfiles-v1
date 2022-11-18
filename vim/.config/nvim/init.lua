local C = {}

function C.base16vim()
  vim.cmd([[colorscheme base16-irblack]])
end

function C.comment()
  require('Comment').setup()
end

function C.cmp()
  -- ref: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  local luasnip = require('luasnip')
  local cmp = require('cmp')
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
  })
end

function C.fidget()
  require('fidget').setup()
end

function C.gitsigns()
  require('gitsigns').setup({
    signcolumn = true,
    current_line_blame = true,
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '▁' },
      topdelete = { text = '▔' },
      changedelete = { text = '░' },
    },
  })
end

function C.indent_blankline()
  require('indent_blankline').setup({
    char = '',
    char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
    },
    space_char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
    },
    show_trailing_blankline_indent = false,
  })
end

function C.leap()
  require('leap').set_default_keymaps()
end

function C.lsp()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local map_key = vim.keymap.set
  local lsp = require('lspconfig')

  lsp.clangd.setup({
    capabilities = capabilities,
  })

  lsp.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        assist = {
          importGranularity = 'module',
          importPrefix = 'self',
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })

  lsp.tsserver.setup({
    capabilities = capabilities,
  })

  lsp.pylsp.setup({
    capabilities = capabilities,
  })

  lsp.sumneko_lua.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        telemetry = {
          enable = false,
        },
      }
    }
  })

  --ref: https://sharksforarms.dev/posts/neovim-rust/
  local opts = { noremap = true, silent = true }
  map_key('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map_key('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map_key('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map_key('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map_key('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map_key('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map_key('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  map_key('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  map_key('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
end

function C.lualine()
  require('lualine').setup({
    options = { theme = 'onedark', component_separators = '', section_separators = '' },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        { 'diff' },
      },
      lualine_c = { 'filename' },
      lualine_x = {
        { 'diagnostics', sources = { 'nvim_diagnostic' } },
        { 'fileformat' },
        'filetype',
      },
      lualine_y = { 'progess' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        { 'buffers', mode = 2 },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  })
end

function C.mason()
  require('mason').setup()
end

function C.mason_lspconfig()
  require('mason-lspconfig').setup({
    ensure_installed = {
      'eslint',
      'jsonls',
      'pyright',
      'rust_analyzer',
      'sumneko_lua',
      'taplo',
      'tflint',
      'tsserver',
      'yamlls',
    }
  })
end

function C.telescope()
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
end

function C.toggleterm()
  require('toggleterm').setup({
    open_mapping = [[<c-\>]],
    direction = 'float',
  })
end

function C.treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'rust' },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    indent = { enabled = true },
  })
end

function C.treesitter_context()
  require('treesitter-context').setup()
end

function C.whichkey()
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
end

local setup = {}

function setup.rainbow()
  vim.g.rainbow_active = 1
end

local function vim_plugins(use)
  -- Base16 for Vim
  use({ 'chriskempson/base16-vim', commit = '6191622', config = C.base16vim })
  -- Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration
  use({ 'luochen1990/rainbow', commit = 'c18071e', setup = setup.rainbow })
  -- Better whitespace highlighting for Vim
  use({ 'ntpeters/vim-better-whitespace', commit = 'c5afbe9' })
  -- Git commands in nvim
  use({ 'tpope/vim-fugitive', commit = '5b62c75' })
  -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
  use({ 'tpope/vim-surround', commit = 'bf3480d' })
  -- unimpaired.vim: Pairs of handy bracket mappings
  use({ 'tpope/vim-unimpaired', commit = '9842718' })
  -- zoomwintab vim plugin
  use({ 'troydm/zoomwintab.vim', commit = '7a354f3' })
end

local function neovim_plugins(use)
  -- A neovim lua plugin to help easily manage multiple terminal windows
  use({ 'akinsho/toggleterm.nvim', commit = 'c525442', config = C.toggleterm })
  -- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you started typing
  use({ 'folke/which-key.nvim', commit = 'bd4411a', config = C.whichkey })
  -- A unified, minimal, extensible interface for lightning-fast movements in the visible editor area
  use({ 'ggandor/leap.nvim', commit = 'b9bc061', config = C.leap })
  -- EditorConfig plugin for Neovim
  use({ 'gpanders/editorconfig.nvim', commit = '495d3e2' })
  -- Standalone UI for nvim-lsp progress
  use({ 'j-hui/fidget.nvim', commit = '492492e', config = C.fidget })
  -- lua `fork` of vim-web-devicons for neovim
  use({ 'kyazdani42/nvim-web-devicons', commit = 'cde67b5' })
  -- Git integration for buffers
  use({
    'lewis6991/gitsigns.nvim',
    commit = '9ff7dfb',
    requires = { 'nvim-lua/plenary.nvim' },
    config = C.gitsigns,
  })
  -- Indent guides for Neovim
  use({
    'lukas-reineke/indent-blankline.nvim',
    commit = '8567ac8',
    config = C.indent_blankline,
  })
  -- // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  use({ 'numToStr/Comment.nvim', commit = '40f5587', config = C.comment })
  -- All the lua functions I don't want to write twice
  use({ 'nvim-lua/plenary.nvim', commit = 'bbd13b1' })
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
  use({
    'nvim-lualine/lualine.nvim',
    commit = 'a4e4517',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = C.lualine,
  })
  -- Nvim Treesitter configurations and abstraction layer
  use({ 'nvim-treesitter/nvim-treesitter', commit = '1942f35', config = C.treesitter })
  -- Show code context
  use({
    'nvim-treesitter/nvim-treesitter-context',
    commit = 'a791652',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = C.treesitter_context,
  })
  -- Neovim plugin to preview the contents of the registers
  use({ 'tversteeg/registers.nvim', commit = 'f354159' })
  -- Make Vim handle line and column numbers in file names with a minimum of fuss
  use({ 'wsdjeg/vim-fetch', commit = '0a6ab17' })
end

local function telescope_plugins(use)
  -- Find, Filter, Preview, Pick. All lua, all the time
  use({
    'nvim-telescope/telescope.nvim',
    commit = '01fc5a9',
    requires = { 'nvim-lua/plenary.nvim' },
    config = C.telescope,
  })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', commit = '2330a7e', run = 'make' })
end

local function lsp_plugins(use)
  -- nvim-cmp source for buffer words
  use({ 'hrsh7th/cmp-buffer', commit = '12463cf' })
  -- nvim-cmp source for vim's cmdline
  use({ 'hrsh7th/cmp-cmdline', commit = 'c36ca4b' })
  -- nvim-cmp source for neovim builtin LSP client
  use({ 'hrsh7th/cmp-nvim-lsp', commit = 'affe808' })
  -- nvim-cmp source for path
  use({ 'hrsh7th/cmp-path', commit = '466b6b8' })
  -- luasnip completion source for nvim-cmp
  use({ 'saadparwaiz1/cmp_luasnip', commit = 'a9de941' })
  -- A completion plugin for neovim coded in Lua
  use({ 'hrsh7th/nvim-cmp', commit = 'cd694b8', config = C.cmp })
  -- Snippet Engine for Neovim written in Lua
  use({ 'L3MON4D3/LuaSnip', commit = '07cf1a1' })
  -- Quickstart configurations for the Nvim LSP client
  use({ 'neovim/nvim-lspconfig', commit = '629f45d', config = C.lsp })
  -- Repo to hold a bunch of info & extension callbacks for built-in LSP
  use({ 'nvim-lua/lsp_extensions.nvim', commit = '4011f4a' })
  -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
  use({ 'williamboman/mason.nvim', commit = 'd85d71e', config = C.mason })
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
  use({ 'williamboman/mason-lspconfig.nvim', commit = 'a910b4d', config = C.mason_lspconfig })
end

-- ref: https://github.com/nvim-lua/kickstart.nvim/blob/fd7f05d872092673ef6a883f72edbf859d268a2e/init.lua
local function setup_packer(use)
  -- A use-package inspired plugin manager for Neovim
  use({ 'wbthomason/packer.nvim', commit = '145716' })
  vim_plugins(use)
  neovim_plugins(use)
  telescope_plugins(use)
  lsp_plugins(use)
end

local F = {}

function F.augroups()
  -- Treat words with dash as a word in Vim
  -- ref: https://til.hashrocket.com/posts/t8osyzywau-treat-words-with-dash-as-a-word-in-vim
  local chg = vim.api.nvim_create_augroup('CssHtmlGroup', { clear = true })
  vim.api.nvim_create_autocmd('filetype', {
    pattern = 'css,html',
    group = chg,
    command = 'setlocal iskeyword+=-',
  })
end

function F.keymappings()
  local map_key = vim.keymap.set

  -- Map semicolon to colon
  -- ref: https://vim.fandom.com/wiki/Map_semicolon_to_colon
  map_key('n', ';', ':', {})
  map_key('v', ';', ':', {})

  -- Retain the visual selection after having pressed > or <
  -- ref: https://vim.fandom.com/wiki/Shifting_blocks_visually#Mappings
  map_key('v', '>', '>gv', { noremap = true })
  map_key('v', '<', '<gv', { noremap = true })
end

function F.options()
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
  c([[highlight IndentBlanklineIndent1 guibg=#121212 gui=nocombine]])
  c([[highlight IndentBlanklineIndent2 guibg=#212121 gui=nocombine]])
end

function F.shoval()
  -- shoves all those files into three directories, rather than individual local project directories
  -- ref: https://sts10.github.io/2016/02/13/best-of-my-vimrc.html

  local sf = string.format
  local c = vim.call
  local o = vim.opt
  local h = os.getenv('HOME')

  c('system', sf('mkdir -p %s/.vim/backup', h))
  o.backupdir = sf([[%s/.vim/backup]], h)

  c('system', sf('mkdir -p %s/.vim/swap', h))
  o.directory = sf([[%s/.vim/swap]], h)

  local d = sf('%s/.vim/undo', h)
  c('system', sf('mkdir -p %s', d))
  o.undodir = d
  o.undofile = true
  o.undolevels = 1000
  o.undoreload = 1000
end

for _, v in pairs(F) do
  v()
end

require('packer').startup(setup_packer)
