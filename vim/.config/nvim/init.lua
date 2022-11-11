local function vim_plugins(use)
  -- Base16 for Vim
  use({ 'chriskempson/base16-vim', commit = '6191622', config = [[require('config.base16vim')]] })
  -- Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration
  use({ 'luochen1990/rainbow', commit = 'c18071e', setup = [[require('setup.rainbow')]] })
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
  use({ 'akinsho/toggleterm.nvim', commit = 'c525442', config = [[require('config.toggleterm')]] })
  -- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you started typing
  use({ 'folke/which-key.nvim', commit = 'bd4411a', config = [[require('config.whichkey')]] })
  -- A unified, minimal, extensible interface for lightning-fast movements in the visible editor area
  use({ 'ggandor/leap.nvim', commit = 'b9bc061', config = [[require('config.leap')]] })
  -- EditorConfig plugin for Neovim
  use({ 'gpanders/editorconfig.nvim', commit = '495d3e2' })
  -- Standalone UI for nvim-lsp progress
  use({ 'j-hui/fidget.nvim', commit = '492492e', config = [[require('config.fidget')]] })
  -- lua `fork` of vim-web-devicons for neovim
  use({ 'kyazdani42/nvim-web-devicons', commit = 'cde67b5' })
  -- Git integration for buffers
  use({
    'lewis6991/gitsigns.nvim',
    commit = '9ff7dfb',
    requires = { 'nvim-lua/plenary.nvim' },
    config = [[require('config.gitsigns')]],
  })
  -- Indent guides for Neovim
  use({
    'lukas-reineke/indent-blankline.nvim',
    commit = '8567ac8',
    config = [[require('config.indentblankline')]],
  })
  -- // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  use({ 'numToStr/Comment.nvim', commit = '40f5587', config = [[require('config.comment')]] })
  -- All the lua functions I don't want to write twice
  use({ 'nvim-lua/plenary.nvim', commit = 'bbd13b1' })
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
  use({
    'nvim-lualine/lualine.nvim',
    commit = 'a4e4517',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = [[require('config.lualine')]],
  })
  -- Nvim Treesitter configurations and abstraction layer
  -- use({ 'nvim-treesitter/nvim-treesitter', commit = '1942f35', config = [[require('config.treesitter')]] })
  -- Show code context
  -- use({
  --   'nvim-treesitter/nvim-treesitter-context',
  --   commit = 'a791652',
  --   config = [[require('config.treesittercontext')]],
  -- })
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
    config = [[require('config.telescope')]],
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
  use({ 'hrsh7th/nvim-cmp', commit = 'cd694b8', config = [[require('config.cmp')]] })
  -- Snippet Engine for Neovim written in Lua
  use({ 'L3MON4D3/LuaSnip', commit = '07cf1a1' })
  -- Quickstart configurations for the Nvim LSP client
  use({ 'neovim/nvim-lspconfig', commit = '629f45d', config = [[require('config.lsp')]] })
  -- Repo to hold a bunch of info & extension callbacks for built-in LSP
  use({ 'nvim-lua/lsp_extensions.nvim', commit = '4011f4a' })
  -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
  use({ 'williamboman/mason.nvim', commit = 'd85d71e', config = [[require('config.mason')]] })
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
  use({ 'williamboman/mason-lspconfig.nvim', commit = 'a910b4d', config = [[require('config.mason-lspconfig')]] })
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

require('augroups')
require('keymappings')
require('options')
require('shoval')

require('packer').startup(setup_packer)
