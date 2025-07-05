return {
  {
    'vim-tmux-navigator',
    dir = nixCats.pawsible.allPlugins.start['vim-tmux-navigator'],
    lazy = false,
    config = function()
      vim.g.tmux_navigator_no_mappings = 1

      vim.g.tmux_navigator_save_on_switch = 0

      -- Smart navigation function that handles explorer edge case
      local function smart_navigate_left()
        local current_buf = vim.api.nvim_get_current_buf()
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = current_buf })
        local filetype = vim.api.nvim_get_option_value('filetype', { buf = current_buf })

        -- Check if we're in an explorer-like buffer and at the leftmost position
        if buftype == 'nofile' or filetype == 'snacks_explorer' or filetype == 'neo-tree' or filetype == 'NvimTree' then
          local current_win = vim.api.nvim_get_current_win()
          local wins = vim.api.nvim_tabpage_list_wins(0)
          local current_col = vim.api.nvim_win_get_position(current_win)[2]

          -- Check if this is the leftmost window
          local is_leftmost = true
          for _, win in ipairs(wins) do
            if win ~= current_win then
              local win_col = vim.api.nvim_win_get_position(win)[2]
              if win_col < current_col then
                is_leftmost = false
                break
              end
            end
          end

          if is_leftmost then
            -- Force tmux navigation for leftmost explorer
            vim.fn.system 'tmux select-pane -L'
            return
          end
        end

        -- For all other cases, use normal navigation
        vim.cmd 'TmuxNavigateLeft'
      end

      -- Set up Alt+hjkl mappings for seamless navigation
      vim.keymap.set('n', '<A-h>', smart_navigate_left, { desc = 'Navigate Left', silent = true })
      vim.keymap.set('n', '<A-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate Down', silent = true })
      vim.keymap.set('n', '<A-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate Up', silent = true })
      vim.keymap.set('n', '<A-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate Right', silent = true })
      vim.keymap.set('n', '<A-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Navigate Previous', silent = true })

      -- Also set up Ctrl+hjkl as backup
      vim.keymap.set('n', '<C-h>', smart_navigate_left, { desc = 'Navigate Left', silent = true })
      vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate Down', silent = true })
      vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate Up', silent = true })
      vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate Right', silent = true })
      vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Navigate Previous', silent = true })
    end,
  },
}
