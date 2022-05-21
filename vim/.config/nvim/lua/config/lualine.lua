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
