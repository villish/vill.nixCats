return {
  {
    'nvim-surround',
    dir = nixCats.pawsible.allPlugins.start['nvim-surround'],
    lazy = false,
    config = function()
      require('nvim-surround').setup {}
    end,
  },
}
