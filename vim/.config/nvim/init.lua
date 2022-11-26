local M = {}

function M.config_autopairs()
  require('nvim-autopairs').setup()
end

function M.config_base16vim()
  vim.cmd([[colorscheme base16-irblack]])
end

function M.config_comment()
  require('Comment').setup()

  local opts = { silent = true }
  vim.keymap.set('n', '<leader>/', [[<cmd>lua require('Comment.api').toggle.linewise.current()<CR>]], opts)
  vim.keymap.set('x', '<leader>/', [[<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>]])
end

function M.config_cmp()
  -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
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

function M.config_fidget()
  require('fidget').setup()
end

function M.config_fugitive()
  local opts = { silent = true }
  vim.keymap.set('n', '<leader>gg', '<cmd>Git<CR>', opts)
  vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
  vim.keymap.set('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', opts)
end

function M.config_gitsigns()
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

function M.config_indent_blankline()
  require('indent_blankline').setup({
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
    space_char_blankline = ' ',
  })
end

function M.config_leap()
  require('leap').set_default_keymaps()
end

function M.config_lsp()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  local lsp = require('lspconfig')

  lsp.bashls.setup({ capabilities = capabilities })
  lsp.clangd.setup({ capabilities = capabilities })
  lsp.pylsp.setup({ capabilities = capabilities })
  lsp.tsserver.setup({ capabilities = capabilities })

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

  -- https://github.com/LunarVim/nvim-basic-ide/blob/39022efc787978c451ee5324888f240c142f6ef3/lua/user/lsp/handlers.lua#L54-L72
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<leader>lI', '<cmd>LspInstallInfo<cr>', opts)
  vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format{ async = true }<cr>', opts)
  vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', opts)
  vim.keymap.set('n', '<leader>lj', '<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>', opts)
  vim.keymap.set('n', '<leader>lk', '<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>', opts)
  vim.keymap.set('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
end

function M.config_lualine()
  local window_width_limit = 100

  -- https://github.com/LunarVim/LunarVim/blob/4d03f65caece1d2f7a25258fe4f37b189be2c6e9/lua/lvim/core/lualine/conditions.lua
  local conditions = {
    hide_in_width = function()
      return vim.o.columns > window_width_limit
    end,
  }

  local components = {
    -- https://github.com/LunarVim/LunarVim/blob/30c65cfd74756954779f3ea9d232938e642bc07f/lua/lvim/core/lualine/components.lua#L113-L162
    lsp = {
      function(msg)
        msg = msg or 'LS inactive'
        local buf_clients = vim.lsp.buf_get_clients()
        if next(buf_clients) == nil then
          -- TODO: clean up this if statement
          if type(msg) == 'boolean' or #msg == 0 then
            return 'LS inactive'
          end
          return msg
        end
        local buf_client_names = {}
        for _, client in pairs(buf_clients) do
          table.insert(buf_client_names, client.name)
        end
        local unique_client_names = vim.fn.uniq(buf_client_names)
        return string.format('[%s]', table.concat(unique_client_names, ','))
      end,
      color = { gui = 'bold' },
      cond = conditions.hide_in_width,
    },
    -- https://github.com/LunarVim/LunarVim/blob/30c65cfd74756954779f3ea9d232938e642bc07f/lua/lvim/core/lualine/components.lua#L187-L199
    scrollbar = {
      function()
        local current_line = vim.fn.line '.'
        local total_lines = vim.fn.line '$'
        local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end,
      padding = { left = 0, right = 0 },
      color = 'SLProgress',
      cond = nil,
    },
    -- https://github.com/LunarVim/LunarVim/blob/57c159fe3c4aec49aeb5a4df78275e7092fc21fa/lua/lvim/core/lualine/components.lua#L83-L93
    treesitter = {
      function()
        return ''
      end,
      color = function()
        local buf = vim.api.nvim_get_current_buf()
        local ts = vim.treesitter.highlighter.active[buf]
        return { fg = ts and not vim.tbl_isempty(ts) and 'green' or 'red' }
      end,
      cond = conditions.hide_in_width,
    },
  }

  require('lualine').setup({
    options = { theme = 'onedark', component_separators = '', section_separators = '' },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'diff' },
      lualine_x = {
        { 'diagnostics', sources = { 'nvim_diagnostic' } },
        components.treesitter,
        components.lsp,
        'fileformat',
        'filetype',
      },
      lualine_y = { 'location' },
      lualine_z = {
        'progess',
        components.scrollbar,
      },
    },
    inactive_sections = {},
    tabline = {
      lualine_a = {
        { 'buffers', mode = 2 },
      },
    },
  })
end

function M.config_mason()
  require('mason').setup()
end

function M.config_mason_lspconfig()
  require('mason-lspconfig').setup({
    ensure_installed = {
      'bashls',
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

function M.config_telescope()
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = {
          preview_width = 0.6,
          width = 0.8,
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
  vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope git_files<CR>')
  vim.keymap.set('n', '<leader>fF', '<cmd>Telescope find_files hidden=true<CR>')
  vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
  vim.keymap.set('n', '<leader>ft', '<cmd>Telescope live_grep<CR>')
end

function M.config_toggleterm()
  require('toggleterm').setup({
    open_mapping = [[<c-\>]],
    direction = 'float',
  })
end

function M.config_treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'python', 'rust' },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    indent = { enabled = true },
  })
end

function M.config_treesitter_context()
  require('treesitter-context').setup()
end

function M.config_whichkey()
  require('which-key').setup()
end

function M.config_zoomwintab()
  local opts = { silent = true }
  vim.keymap.set('n', '<leader>z', '<cmd>call zoomwintab#Toggle()<CR>', opts)
end

function M.setup_rainbow()
  vim.g.rainbow_active = 1
end

function M.use_vim_plugins(use)
  -- Base16 for Vim
  use({ 'chriskempson/base16-vim', commit = '6191622' })
  -- Rainbow Parentheses Improved, shorter code, no level limit, smooth and fast, powerful configuration
  use({ 'luochen1990/rainbow', commit = 'c18071e', setup = M.setup_rainbow })
  -- Better whitespace highlighting for Vim
  use({ 'ntpeters/vim-better-whitespace', commit = 'c5afbe9' })
  -- Git commands in nvim
  use({ 'tpope/vim-fugitive', commit = '5b62c75', config = M.config_fugitive })
  -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
  use({ 'tpope/vim-surround', commit = 'bf3480d' })
  -- unimpaired.vim: Pairs of handy bracket mappings
  use({ 'tpope/vim-unimpaired', commit = '9842718' })
  -- zoomwintab vim plugin
  use({ 'troydm/zoomwintab.vim', commit = '7a354f3', config = M.config_zoomwintab })
end

function M.use_neovim_plugins(use)
  -- A neovim lua plugin to help easily manage multiple terminal windows
  use({ 'akinsho/toggleterm.nvim', commit = 'c525442', config = M.config_toggleterm })
  -- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible key bindings of the command you started typing
  use({ 'folke/which-key.nvim', commit = 'bd4411a', config = M.config_whichkey })
  -- A unified, minimal, extensible interface for lightning-fast movements in the visible editor area
  use({ 'ggandor/leap.nvim', commit = 'b9bc061', config = M.config_leap })
  -- EditorConfig plugin for Neovim
  use({ 'gpanders/editorconfig.nvim', commit = '495d3e2' })
  -- Standalone UI for nvim-lsp progress
  use({ 'j-hui/fidget.nvim', commit = '492492e', config = M.config_fidget })
  -- lua `fork` of vim-web-devicons for neovim
  use({ 'kyazdani42/nvim-web-devicons', commit = 'cde67b5' })
  -- Git integration for buffers
  use({
    'lewis6991/gitsigns.nvim',
    commit = '9ff7dfb',
    requires = { 'nvim-lua/plenary.nvim' },
    config = M.config_gitsigns,
  })
  -- Indent guides for Neovim
  use({
    'lukas-reineke/indent-blankline.nvim',
    commit = '8567ac8',
    config = M.config_indent_blankline,
  })
  -- // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  use({ 'numToStr/Comment.nvim', commit = 'cd1c381', config = M.config_comment })
  -- All the lua functions I don't want to write twice
  use({ 'nvim-lua/plenary.nvim', commit = 'bbd13b1' })
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
  use({
    'nvim-lualine/lualine.nvim',
    commit = 'a4e4517',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = M.config_lualine,
  })
  -- Nvim Treesitter configurations and abstraction layer
  use({ 'nvim-treesitter/nvim-treesitter', commit = '1942f35', config = M.config_treesitter })
  -- Show code context
  use({
    'nvim-treesitter/nvim-treesitter-context',
    commit = 'a791652',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = M.config_treesitter_context,
  })
  -- Neovim plugin to preview the contents of the registers
  use({ 'tversteeg/registers.nvim', commit = 'f354159' })
  -- autopairs for neovim written by lua
  use({ 'windwp/nvim-autopairs', commit = '4fc96c8', config = M.config_autopairs })
  -- Make Vim handle line and column numbers in file names with a minimum of fuss
  use({ 'wsdjeg/vim-fetch', commit = '0a6ab17' })
end

function M.use_telescope_plugins(use)
  -- Find, Filter, Preview, Pick. All lua, all the time
  use({
    'nvim-telescope/telescope.nvim',
    commit = '01fc5a9',
    requires = { 'nvim-lua/plenary.nvim' },
    config = M.config_telescope,
  })
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    commit = '2330a7e',
    requires = { 'nvim-telescope/telescope.nvim' },
    run = 'make',
  })
end

function M.use_lsp_plugins(use)
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
  use({ 'hrsh7th/nvim-cmp', commit = 'cd694b8', config = M.config_cmp })
  -- Snippet Engine for Neovim written in Lua
  use({ 'L3MON4D3/LuaSnip', commit = '07cf1a1' })
  -- Quickstart configurations for the Nvim LSP client
  use({ 'neovim/nvim-lspconfig', commit = '629f45d', config = M.config_lsp })
  -- Repo to hold a bunch of info & extension callbacks for built-in LSP
  use({ 'nvim-lua/lsp_extensions.nvim', commit = '4011f4a' })
  -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
  use({ 'williamboman/mason.nvim', commit = 'd85d71e', config = M.config_mason })
  -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim. Strongly recommended for Windows users.
  use({
    'williamboman/mason-lspconfig.nvim',
    commit = 'a910b4d',
    require = { 'williamboman/mason.nvim' },
    config = M.config_mason_lspconfig
  })
end

-- https://github.com/nvim-lua/kickstart.nvim/blob/fd7f05d872092673ef6a883f72edbf859d268a2e/init.lua
function M.setup_packer(use)
  -- A use-package inspired plugin manager for Neovim
  use({ 'wbthomason/packer.nvim', commit = '145716' })
  M.use_vim_plugins(use)
  M.use_neovim_plugins(use)
  M.config_base16vim()
  M.use_telescope_plugins(use)
  M.use_lsp_plugins(use)
end

function M.augroups()
  -- Treat words with dash as a word in Vim
  -- https://til.hashrocket.com/posts/t8osyzywau-treat-words-with-dash-as-a-word-in-vim
  local css_html_group = vim.api.nvim_create_augroup('CssHtmlGroup', { clear = true })
  vim.api.nvim_create_autocmd('filetype', {
    pattern = 'css,html',
    group = css_html_group,
    command = 'setlocal iskeyword+=-',
  })

  -- https://github.com/ntpeters/vim-better-whitespace/issues/158
  local vimrc_group = vim.api.nvim_create_augroup('vimrc', { clear = true })
  vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    group = vimrc_group,
    command = 'DisableWhitespace',
  })
end

function M.keymappings()
  -- Map semicolon to colon
  -- https://vim.fandom.com/wiki/Map_semicolon_to_colon
  vim.keymap.set('n', ';', ':', {})
  vim.keymap.set('v', ';', ':', {})

  -- Retain the visual selection after having pressed > or <
  -- https://vim.fandom.com/wiki/Shifting_blocks_visually#Mappings
  vim.keymap.set('v', '>', '>gv', { noremap = true })
  vim.keymap.set('v', '<', '<gv', { noremap = true })

  -- https://github.com/LunarVim/nvim-basic-ide/blob/fa51853c0890bf9992b6fc880025853772ecbdb0/lua/user/keymaps.lua
  local opts = { silent = true }
  vim.keymap.set('', '<Space>', '<Nop>', opts)
  vim.g.mapleader = ' '

  vim.keymap.set('n', '<leader>h', '<cmd>nohls<CR>', opts)
  vim.keymap.set('n', '<leader>ve', '<cmd>edit $MYVIMRC<CR>', opts)

  local cmd = [[
    <cmd>source $MYVIMRC<CR>
    <cmd>PackerCompile<CR>
    <cmd>echo $MYVIMRC 'sourced'<CR>
    ]]
  vim.keymap.set('n', '<leader>vs', cmd, opts)
end

function M.options()
  -- Using the mouse for Vim in an xterm
  -- https://vim.fandom.com/wiki/Using_the_mouse_for_Vim_in_an_xterm
  vim.opt.mouse = 'a'

  -- Result in spaces being used for all indentation
  -- https://vim.fandom.com/wiki/Indenting_source_code
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4

  -- Does nothing more than copy the indentation from the previous line, when starting a new line
  -- https://vim.fandom.com/wiki/Indenting_source_code
  vim.opt.autoindent = true

  -- Make backspace work like most other programs
  -- https://vim.fandom.com/wiki/Backspace_and_delete_problems#Backspace_key_won.27t_move_from_current_line
  vim.opt.backspace = 'indent,eol,start'

  -- Highlighting that moves with the cursor
  -- https://vim.fandom.com/wiki/Highlight_current_line
  vim.opt.laststatus = 2
  vim.opt.cursorline = true
  vim.opt.number = true
  -- https://github.com/neovim/neovim/issues/18160
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'lightgrey' })

  -- By setting the option 'hidden', you can load a buffer in a window that currently has a modified buffer
  -- http://vimdoc.sourceforge.net/htmldoc/options.html#'hidden'
  vim.opt.hidden = true

  -- Case sensitivity
  -- https://vim.fandom.com/wiki/Searching#Case_sensitivity
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Show the next match while entering a search
  -- https://vim.fandom.com/wiki/Searching#Show_the_next_match_while_entering_a_search
  vim.opt.incsearch = true

  -- What do you use for your listchars?
  -- https://www.reddit.com/r/vim/comments/4hoa6e/comment/d2ra7qh/
  vim.opt.list = true
  vim.opt.listchars = {
    eol = '⤶',
    extends = '›',
    nbsp = '·',
    precedes = '‹',
    tab = '» ',
    trail = '·',
  }

  -- Vim highlights the remaining matches with the Search highlight group
  -- https://vim.fandom.com/wiki/Search_and_replace#Basic_search_and_replace
  vim.opt.hlsearch = true

  -- Does not change the text but simply displays it on multiple lines
  -- https://vim.fandom.com/wiki/Automatic_word_wrapping
  vim.opt.wrap = true

  -- With custom background highlight
  -- https://github.com/lukas-reineke/indent-blankline.nvim/tree/8567ac8ccd19ee41a6ec55bf044884799fa3f56b
  vim.opt.termguicolors = true
end

function M.shoval()
  -- shoves all those files into three directories, rather than individual local project directories
  -- https://sts10.github.io/2016/02/13/best-of-my-vimrc.html

  local home = os.getenv('HOME')

  vim.call('system', string.format('mkdir -p %s/.vim/backup', home))
  vim.opt.backupdir = string.format([[%s/.vim/backup]], home)

  vim.call('system', string.format('mkdir -p %s/.vim/swap', home))
  vim.opt.directory = string.format([[%s/.vim/swap]], home)

  local undo = string.format('%s/.vim/undo', home)
  vim.call('system', string.format('mkdir -p %s', undo))
  vim.opt.undodir = undo
  vim.opt.undofile = true
  vim.opt.undolevels = 1000
  vim.opt.undoreload = 1000
end

function M.init()
  M.augroups()
  M.keymappings()
  M.options()
  M.shoval()
  require('packer').startup(M.setup_packer)
end

M.init()

-- vim: set ts=2 sw=2:
