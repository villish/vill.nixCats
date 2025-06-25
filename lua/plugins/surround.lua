return {
  {
    'nvim-surround',
    -- Tell lazy this is a local plugin, not from GitHub
    dir = nixCats.pawsible.allPlugins.start['nvim-surround'],
    lazy = false,
    config = function()
      require('nvim-surround').setup {
        -- Add your custom settings here, or leave empty for defaults
      }
    end,
  },
}
