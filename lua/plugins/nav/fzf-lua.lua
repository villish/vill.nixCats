return {
  {
    'fzf-lua',
    dir = nixCats.pawsible.allPlugins.start['fzf-lua'],
    opts = {
      -- Disable the default <a-h> keymaps that conflict
      keymap = {
        builtin = {
          ['<a-h>'] = false,
        },
        fzf = {
          ['alt-h'] = false,
        },
      },
      -- Custom keymaps similar to telescope
      actions = {
        files = {
          ['<leader>h'] = function(selected, opts)
            require('fzf-lua').files {
              cwd = selected[1],
              hidden = true,
            }
          end,
        },
      },
    },
  },
}
