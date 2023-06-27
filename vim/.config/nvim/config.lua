--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
--]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "base16-bright"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- Besides disabling indentation, I also need to completely disable Python treesitter to prevent the bug.
-- ref: https://github.com/LunarVim/LunarVim/issues/1867
lvim.builtin.treesitter.ignore_install = { "python" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "pylyzer" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "pylsp" and server ~= "eslint"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } }
}

-- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  -- Neovim plugin for building a sync base16 colorscheme. Includes support for Treesitter and LSP highlight groups.
  { "RRethy/nvim-base16",             commit = "da2a27c" },
  -- A unified, minimal, extensible interface for lightning-fast movements in the visible editor area
  {
    "ggandor/leap.nvim",
    commit = "b9bc061",
    config = function()
      require('leap').set_default_keymaps()
    end
  },
  -- EditorConfig plugin for Neovim
  {
    "gpanders/editorconfig.nvim",
    commit = "495d3e2",
    config = function()
      require("fidget").setup()
    end
  },
  -- Standalone UI for nvim-lsp progress
  { "j-hui/fidget.nvim",              commit = "492492e" },
  -- Better whitespace highlighting for Vim
  { "ntpeters/vim-better-whitespace", commit = "c5afbe9" },
  -- repeat.vim: enable repeating supported plugin maps with "."
  { "tpope/vim-repeat",               commit = "24afe92" },
  -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
  { "tpope/vim-surround",             commit = "bf3480d" },
  -- unimpaired.vim: Pairs of handy bracket mappings
  { "tpope/vim-unimpaired",           commit = "9842718" },
  -- zoomwintab vim plugin
  { "troydm/zoomwintab.vim",          commit = "7a354f3" },
  -- Neovim plugin to preview the contents of the registers
  { "tversteeg/registers.nvim",       commit = "f354159" },
  -- Make Vim handle line and column numbers in file names with a minimum of fuss
  { "wsdjeg/vim-fetch",               commit = "0a6ab17" }
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

-- Map semicolon to colon
-- ref: https://vim.fandom.com/wiki/Map_semicolon_to_colon
vim.keymap.set("n", ";", ":", {})
vim.keymap.set("v", ";", ":", {})
