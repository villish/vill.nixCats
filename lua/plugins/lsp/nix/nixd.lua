return {
  'neovim/nvim-lspconfig',
  dir = nixCats.pawsible.allPlugins.start['nvim-lspconfig'],
  event = 'VeryLazy',
  opts = {
    servers = {
      nixd = {
        nixpkgs = { expr = 'import <nixpkgs> { }' },
        formatting = {
          command = { 'nixfmt' },
        },
        options = {
          nixos = {
            expr = '(builtins.getFlake "$HOME/nixos-config").nixosConfigurations.CONFIGNAME.options',
          },
          home_manager = {
            expr = '(builtins.getFlake "$HOME/nixos-config").homeConfigurations.CONFIGNAME.options',
          },
        },
        cmd = { 'nixd' },
        filetypes = { 'nix' },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern('flake.nix', 'flake.lock')(fname)
        end,
      },
    },
  },
}
