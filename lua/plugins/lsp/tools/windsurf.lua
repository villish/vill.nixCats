return {
  {
    'windsurf.nvim',
    dir = nixCats.pawsible.allPlugins.start['windsurf.nvim'],
    lazy = false,
    cmd = 'Codeium',
    event = 'InsertEnter',
    build = ':Codeium Auth',
    opts = {
      enable_cmp_source = false,  -- Disabled because we use blink.cmp
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = '<Tab>',
          next = '<M-]>',
          prev = '<M-[>',
        },
      },
    },
    config = function(_, opts)
      require('codeium').setup(opts)
    end,
  },
}
