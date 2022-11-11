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
