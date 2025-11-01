return {
  {
    'crates.nvim',
    dir = nixCats.pawsible.allPlugins.start['crates.nvim'],
    lazy = false,
    ft = { 'toml' },
    config = function()
      local crates = require 'crates'

      crates.setup {
        completion = {
          blink = {
            use_custom_kind = true,
            kind_text = {
              version = 'Version',
              feature = 'Feature',
            },
            kind_highlight = {
              version = 'BlinkCmpKindVersion',
              feature = 'BlinkCmpKindFeature',
            },
            kind_icon = {
              version = ' ',
              feature = ' ',
            },
          },
          crates = {
            enabled = true,
            min_chars = 3,
            max_results = 8,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
        smart_insert = true,
        autoload = true,
        autoupdate = true,
      }

      vim.api.nvim_create_autocmd('BufRead', {
        group = vim.api.nvim_create_augroup('CratesNvimKeymaps', { clear = true }),
        pattern = 'Cargo.toml',
        callback = function()
          local opts = { silent = true, buffer = true }

          vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, vim.tbl_extend('force', opts, { desc = 'Show crate versions' }))
          vim.keymap.set('n', '<leader>cf', crates.show_features_popup, vim.tbl_extend('force', opts, { desc = 'Show crate features' }))
          vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, vim.tbl_extend('force', opts, { desc = 'Show crate dependencies' }))

          vim.keymap.set('n', '<leader>cu', crates.update_crate, vim.tbl_extend('force', opts, { desc = 'Update crate' }))
          vim.keymap.set('v', '<leader>cu', crates.update_crates, vim.tbl_extend('force', opts, { desc = 'Update selected crates' }))
        end,
      })
    end,
  },
}
