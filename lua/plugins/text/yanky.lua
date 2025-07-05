return {
  'yanky.nvim',
  dir = nixCats.pawsible.allPlugins.start['yanky.nvim'],
  lazy = false,
  config = function()
    require('yanky').setup()
  end,
}
