return {
  'hedyhli/outline.nvim',
  dir = nixCats.pawsible.allPlugins.start['outline.nvim'],
  event = 'VeryLazy',
  config = function()
    require('outline').setup {}
    vim.keymap.set('n', '<leader>co', require('outline').toggle_outline, { desc = 'Toggle Outline' })
  end,
}
