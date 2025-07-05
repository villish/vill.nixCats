return {
  {
    'nvim-tree/nvim-web-devicons',
    dir = nixCats.pawsible.allPlugins.start['nvim-web-devicons'],
    lazy = false,
    config = function()
      require('nvim-web-devicons').setup()
    end,
  },
}
