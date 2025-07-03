return {
  {
    'render-markdown.nvim',
    -- Tell lazy this is a local plugin, not from GitHub
    dir = nixCats.pawsible.allPlugins.start['render-markdown-nvim'],
    lazy = false,
    ft = { 'markdown' }, -- Only load for markdown files
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-web-devicons', -- Optional: for file icons
    },
    config = function()
      require('render-markdown').setup {
        enabled = true,
        max_file_size = 5.0, -- MB
        debounce = 100,

        completions = {
          lsp = { enabled = true },
          blink = { enabled = true },
        },

        render = {
          max_file_size = 5.0,
          debounce = 100,
        },

        anti_conceal = {
          enabled = true,
        },

        sign = {
          enabled = false,
        },

        code = {
          enabled = true,
          sign = false,
          style = 'full',
          position = 'left',
          language_pad = 0,
          disable_background = { 'diff' },
        },

        heading = {
          enabled = true,
          sign = false,
          position = 'overlay',
          icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          signs = { 'RenderMarkdownH1', 'RenderMarkdownH2', 'RenderMarkdownH3', 'RenderMarkdownH4', 'RenderMarkdownH5', 'RenderMarkdownH6' },
          width = 'full',
          left_pad = 0,
          right_pad = 0,
          min_width = 0,
          border = false,
          border_prefix = false,
          above = '▄',
          below = '▀',
          backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg',
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
          },
          foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
          },
        },

        bullet = {
          enabled = true,
          icons = { '●', '○', '◆', '◇' },
          left_pad = 0,
          right_pad = 0,
          highlight = 'RenderMarkdownBullet',
        },

        checkbox = {
          enabled = true,
          position = 'overlay',
          unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
          },
          checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownChecked',
          },
          custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
          },
        },

        quote = {
          enabled = true,
          icon = '▋',
          repeat_linebreak = false,
          highlight = 'RenderMarkdownQuote',
        },

        pipe_table = {
          enabled = true,
          preset = 'none',
          style = 'full',
          cell = 'padded',
          padding = 1,
          border = {
            '┌',
            '┬',
            '┐',
            '├',
            '┼',
            '┤',
            '└',
            '┴',
            '┘',
            '│',
            '─',
          },
          alignment_indicator = '━',
          head = 'RenderMarkdownTableHead',
          row = 'RenderMarkdownTableRow',
          filler = 'RenderMarkdownTableFill',
        },

        callout = {
          note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
          tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
          important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
          warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
          caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
        },

        link = {
          enabled = true,
          image = '󰥶 ',
          email = '󰀓 ',
          hyperlink = '󰌹 ',
          highlight = 'RenderMarkdownLink',
          custom = {},
        },

        html = {
          enabled = true,
        },

        latex = {
          enabled = true,
          converter = 'latex2text',
          highlight = 'RenderMarkdownMath',
          top_pad = 0,
          bottom_pad = 0,
        },

        win_options = {
          conceallevel = {
            default = vim.api.nvim_get_option_value('conceallevel', {}),
            rendered = 3,
          },
          concealcursor = {
            default = vim.api.nvim_get_option_value('concealcursor', {}),
            rendered = '',
          },
        },
      }
    end,
  },
}
