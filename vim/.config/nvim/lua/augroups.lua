-- Treat words with dash as a word in Vim
-- ref: https://til.hashrocket.com/posts/t8osyzywau-treat-words-with-dash-as-a-word-in-vim
local chg = vim.api.nvim_create_augroup('CssHtmlGroup', { clear = true })
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'css,html',
  group = chg,
  command = 'setlocal iskeyword+=-',
})
