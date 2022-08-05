lvim.colorscheme = "base16-bright"
lvim.format_on_save = true
lvim.leader = "space"
lvim.log.level = "warn"

lvim.builtin.bufferline.options.always_show_bufferline = true

local comp = require "lvim.core.lualine.components"

lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.lualine.sections.lualine_b = { comp.branch, comp.filename }
lvim.builtin.lualine.sections.lualine_c = { comp.diagnostics }
lvim.builtin.lualine.sections.lualine_x = { comp.diff, comp.treesitter, comp.lsp }
lvim.builtin.lualine.sections.lualine_z = { comp.scrollbar }
lvim.builtin.lualine.style = "default"

lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = [[<c-\>]]

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "css",
  "javascript",
  "json",
  "lua",
  "python",
  "rust",
  "tsx",
  "typescript",
  "yaml",
}
lvim.builtin.treesitter.highlight.enabled = true

-- use rust-tools instead
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

lvim.plugins = {
  -- Neovim plugin for building a sync base16 colorscheme. Includes support for Treesitter and LSP highlight groups.
  { "RRethy/nvim-base16", commit = "da2a27c" },
  -- Next-generation motion plugin using incremental input processing, allowing for unparalleled speed with minimal cognitive effort
  { "ggandor/lightspeed.nvim", commit = "a4b4277" },
  -- EditorConfig plugin for Neovim
  { "gpanders/editorconfig.nvim", commit = "495d3e2", config = function()
    require("fidget").setup()
  end },
  --  Standalone UI for nvim-lsp progress
  { "j-hui/fidget.nvim", commit = "492492e" },
  -- Indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    commit = "8567ac8",
    config = function()
      require("indent_blankline").setup()
    end,
  },
  -- Better whitespace highlighting for Vim
  { "ntpeters/vim-better-whitespace", commit = "c5afbe9" },
  -- repeat.vim: enable repeating supported plugin maps with "."
  { "tpope/vim-repeat", commit = "24afe92" },
  -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
  { "tpope/vim-surround", commit = "bf3480d" },
  -- unimpaired.vim: Pairs of handy bracket mappings
  { "tpope/vim-unimpaired", commit = "9842718" },
  -- zoomwintab vim plugin
  { "troydm/zoomwintab.vim", commit = "7a354f3" },
  -- Neovim plugin to preview the contents of the registers
  { "tversteeg/registers.nvim", commit = "f354159" },
  -- Tools for better development in rust using neovim's builtin lsp
  {
    "simrat39/rust-tools.nvim",
    commit = "11dcd67",
    config = function()
      local lsp_installer_servers = require "nvim-lsp-installer.servers"
      local _, requested_server = lsp_installer_servers.get_server "rust_analyzer"
      require("rust-tools").setup({
        tools = {},
        server = {
          cmd_env = requested_server._default_options.cmd_env,
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        },
      })
    end,
    ft = { "rust", "rs" }
  },
  -- Make Vim handle line and column numbers in file names with a minimum of fuss
  { "wsdjeg/vim-fetch", commit = "0a6ab17" }
}

-- Map semicolon to colon
-- ref: https://vim.fandom.com/wiki/Map_semicolon_to_colon
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("v", ";", ":", {})

-- Enable autopep8 for Python
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "autopep8",
    filetypes = { "python" },
  },
}
