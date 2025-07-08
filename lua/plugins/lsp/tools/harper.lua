return {
  'neovim/nvim-lspconfig',
  dir = nixCats.pawsible.allPlugins.start['nvim-lspconfig'],
  event = 'VeryLazy',
  opts = {
    servers = {
      harper_ls = {
        settings = {
          ['harper-ls'] = {
            linters = {
              SpellCheck = false,
              SpelledNumbers = false,
              An_A = true,
              SentenceCapitalization = false,
              UnclosedQuotes = true,
              WrongQuotes = false,
              LongSentences = true,
              RepeatedWords = true,
              Spaces = true,
              Matcher = true,
              CorrectNumberSuffix = true,
              NumberSuffixCapitalization = true,
              MultipleSequentialPronouns = true,
              LinkingVerbs = false,
              AvoidCurses = true,
              TerminatingConjunctions = true,
            },
            codeActions = {
              forceStable = false,
            },
            diagnosticSeverity = 'hint',
            dialect = 'American',
            maxFileLength = 120000,
          },
        },
        filetypes = {
          'markdown',
          'gitcommit',
          'text',
          'txt',
          -- Comments in code files
          'c',
          'cpp',
          'rust',
          'go',
          'javascript',
          'typescript',
          'python',
          'lua',
          'nix',
          'sh',
          'bash',
          'zsh',
        },
      },
    },
  },
}
