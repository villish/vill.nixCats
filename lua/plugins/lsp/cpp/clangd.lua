return {
  'neovim/nvim-lspconfig',
  dir = nixCats.pawsible.allPlugins.start['nvim-lspconfig'],
  event = 'VeryLazy',
  opts = {
    servers = {
      clangd = {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
          '-j=12',
          '--all-scopes-completion',
          '--cross-file-rename',
          '--enable-config',
          '--pch-storage=memory',
          '--suggest-missing-includes',
        },
        keys = {
          { '<leader>ch', '<cmd>ClangdSwitchSourceHeader<cr>', desc = 'Switch Source/Header (C/C++)' },
        },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'Makefile',
            'configure.ac',
            'configure.in',
            'config.h.in',
            'meson.build',
            'meson_options.txt',
            'build.ninja',
            'compile_commands.json',
            'compile_flags.txt'
          )(fname) or require('lspconfig.util').find_git_ancestor(fname)
        end,
        capabilities = {
          offsetEncoding = { 'utf-16' },
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
    },
  },
}
