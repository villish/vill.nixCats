return {
  {
    'snacks.nvim',
    dir = nixCats.pawsible.allPlugins.start['snacks.nvim'],
    opts = {
      -- Existing dashboard config
      dashboard = {
        preset = {
          header = [[
██╗   ██╗██╗██╗     ██╗     ██╗███████╗██╗  ██╗
██║   ██║██║██║     ██║     ██║██╔════╝██║  ██║
██║   ██║██║██║     ██║     ██║███████╗███████║
╚██╗ ██╔╝██║██║     ██║     ██║╚════██║██╔══██║
 ╚████╔╝ ██║███████╗███████╗██║███████║██║  ██║
  ╚═══╝  ╚═╝╚══════╝╚══════╝╚═╝╚══════╝╚═╝  ╚═╝
]],
        },
        sections = {
          { section = 'header' },
          { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          { section = 'startup' },
        },
      },
      -- Existing picker config
      picker = {
        win = {
          input = {
            keys = {
              ['<a-h>'] = false,
            },
          },
          list = {
            keys = {
              ['<a-h>'] = false,
            },
          },
        },
      },
      -- Existing explorer config
      explorer = {
        win = {
          input = {
            keys = {
              ['<a-h>'] = false,
            },
          },
          list = {
            keys = {
              ['<a-h>'] = false,
            },
          },
        },
      },
      -- Add all missing Snacks components
      input = { enabled = true },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
          easing = "linear",
        },
      },
      indent = {
        enabled = true,
        char = "│",
        only_scope = false,
        only_current = false,
        hl = "SnacksIndent",
      },
      scope = {
        enabled = true,
        char = "│",
        underline = false,
        hl = "SnacksScope",
      },
      dim = {
        enabled = true,
        scope = {
          min_size = 5,
          max_size = 20,
          siblings = true,
        },
      },
      zen = {
        enabled = true,
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff = false,
          diagnostics = false,
          inlay_hints = false,
        },
        win = { style = "zen" },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      scratch = {
        enabled = true,
      },
    },
  },
}
