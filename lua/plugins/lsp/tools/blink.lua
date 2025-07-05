return {
  {
    'blink.cmp',
    dir = nixCats.pawsible.allPlugins.start['blink.cmp'],
    lazy = false,
    dependencies = {
      {
        'windsurf.nvim',
        dir = nixCats.pawsible.allPlugins.start['windsurf.nvim'],
      },
      {
        'blink.compat',
        dir = nixCats.pawsible.allPlugins.start['blink.compat'],
      },
    },
    opts = {
      sources = {
        compat = { 'codeium' },
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)
    end,
  },
}
