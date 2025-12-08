-- NOTE: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require('nixCatsUtils').setup {
  non_nix_value = true,
}

-- NOTE: You might want to move the lazy-lock.json file
local function getlockfilepath()
  if require('nixCatsUtils').isNixCats and type(nixCats.settings.unwrappedCfgPath) == 'string' then
    return nixCats.settings.unwrappedCfgPath .. '/lazy-lock.json'
  else
    return vim.fn.stdpath 'config' .. '/lazy-lock.json'
  end
end
local lazyOptions = {
  lockfile = getlockfilepath(),
}
-- NOTE: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require('nixCatsUtils.lazyCat').setup(nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
  -- disable mason.nvim while using nix
  -- precompiled binaries do not agree with nixos, and we can just make nix install this stuff for us.
  { 'mason-org/mason-lspconfig.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'mason-org/mason.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { import = 'lazyvim.plugins.extras.lang.markdown' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = require('nixCatsUtils').lazyAdd(':TSUpdate', false),
    pin = require('nixCatsUtils').lazyAdd(false, true),
    opts = {
      ensure_installed = require('nixCatsUtils').lazyAdd({ 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' }, {}),
      auto_install = require('nixCatsUtils').lazyAdd(true, false),
    },
    config = function()
      -- Suppress Lazy update notifications for treesitter on Nix
      if require('nixCatsUtils').isNixCats then
        vim.g.lazy_nvim_treesitter_updated = true
      end
    end,
  },
  {
    'folke/lazydev.nvim',
    opts = {
      library = {
        { path = (nixCats.nixCatsPath or '') .. '/lua', words = { 'nixCats' } },
        -- Add Nix library support for flake.nix completion
        'nixpkgs',
      },
    },
  },
  -- import/override with your plugins
  { import = 'plugins.ui' },
  { import = 'plugins.text' },
  { import = 'plugins.treesitter' },
  { import = 'plugins.nav' },
  { import = 'plugins.lsp' },
  { import = 'plugins.lsp.cpp.clangd' },
  { import = 'plugins.lsp.nix.nixd' },
  { import = 'plugins.lsp.rust.rustaceanvim' },
  { import = 'plugins.lsp.tools' },
}, lazyOptions)

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.schedule(function()
      -- Set StatusLine to match lualine_c colors to prevent white background
      vim.api.nvim_set_hl(0, 'StatusLine', {
        bg = '#1e1e1e', -- Dark gray to match your lualine
        fg = '#abb2bf', -- Light gray for text
      })
    end)
  end,
})
