return {
  'phaazon/hop.nvim',
  branch = 'v2',
  event = 'BufReadPost',
  opts = {
    keys = 'etovxqpdygfblzhckisuran',
  },
  config = function(_, opts)
    require('hop').setup(opts)

    -- Set up the Enter keybinding for hop
    vim.keymap.set('n', '<CR>', function()
      require('hop').hint_words()
    end, { desc = 'Hop to word' })

    -- Optional: Add visual mode support
    vim.keymap.set('v', '<CR>', function()
      require('hop').hint_words()
    end, { desc = 'Hop to word' })
  end,
}
