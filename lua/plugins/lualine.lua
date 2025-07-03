return {
  'lualine.nvim',
  dir = nixCats.pawsible.allPlugins.start['lualine.nvim'],
  optional = true,
  event = 'VeryLazy',
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source 'codeium')
  end,
}
