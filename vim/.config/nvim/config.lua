lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "base16-bright"

lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.notify.active = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
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
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.plugins = {
  -- Neovim plugin for building a sync base16 colorscheme. Includes support for Treesitter and LSP highlight groups.
  { "RRethy/nvim-base16", commit = "da2a27c" },
  -- Next-generation motion plugin using incremental input processing, allowing for unparalleled speed with minimal cognitive effort
  { "ggandor/lightspeed.nvim", commit = "a4b4277", event = "BufRead" },
  -- EditorConfig plugin for Neovim
  { "gpanders/editorconfig.nvim", commit = "495d3e2" },
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
  -- Make Vim handle line and column numbers in file names with a minimum of fuss
  { "wsdjeg/vim-fetch", commit = "0a6ab17" }
}

-- Map semicolon to colon
-- ref: https://vim.fandom.com/wiki/Map_semicolon_to_colon
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("v", ";", ":", {})
