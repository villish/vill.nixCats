return {
  {
    'blink.cmp',
    dir = nixCats.pawsible.allPlugins.start['blink.cmp'],
    dependencies = {
      {
        'windsurf.nvim',
        dir = nixCats.pawsible.allPlugins.start['windsurf.nvim'],
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      local default = opts.sources.default
      if type(default) == 'table' then
        if not vim.tbl_contains(default, 'codeium') then
          table.insert(default, 'codeium')
        end
      else
        opts.sources.default = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' }
      end

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.codeium = vim.tbl_deep_extend('force', {
        name = 'Codeium',
        module = 'codeium.blink',
        async = true,
      }, opts.sources.providers.codeium or {})

      opts.sources.compat = nil

      -- Enable cmdline completions (LazyVim 15.x feature)
      opts.cmdline = {
        enabled = true,
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == '/' or type == '?' then
            return { 'buffer' }
          end
          if type == ':' then
            return { 'cmdline' }
          end
          return {}
        end,
      }
    end,
  },
}
