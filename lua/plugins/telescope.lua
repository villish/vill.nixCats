return {
  {
    'nvim-telescope/telescope.nvim',
    opts = function(_, opts)
      local actions = require 'telescope.actions'

      opts.defaults = opts.defaults or {}
      opts.defaults.mappings = opts.defaults.mappings or {}
      opts.defaults.mappings.i = opts.defaults.mappings.i or {}

      opts.defaults.mappings.i['<a-h>'] = false

      opts.defaults.mappings.i['<leader>h'] = function()
        local action_state = require 'telescope.actions.state'
        local line = action_state.get_current_line()
        require('telescope.builtin').find_files { hidden = true, default_text = line }
      end

      return opts
    end,
  },
}
