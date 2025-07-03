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
        providers = {
          codeium = {
            name = 'codeium',
            module = 'blink.compat.source',
            kind = 'Codeium',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)
    end,
  },
}
