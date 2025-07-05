return {
  'neovim/nvim-lspconfig',
  dir = nixCats.pawsible.allPlugins.start['nvim-lspconfig'],
  event = 'VeryLazy',
  opts = {
    servers = {
      nil_ls = false,
    },
  },
}
