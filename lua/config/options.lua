local opt = vim.opt

opt.timeoutlen = 1000
vim.g.lazyvim_rust_diagnostics = 'rust-analyzer'

-- Set global variable to enable AI CMP integration
vim.g.ai_cmp = true

-- Enable LSP-based folding (LazyVim 15.x feature)
if vim.fn.has 'nvim-0.11' == 1 then
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
end

-- Enable inlay hints for LSP features like package versions
if vim.lsp.inlay_hint then
  vim.lsp.inlay_hint.enable(true)
end

-- Keymap to toggle inlay hints
vim.keymap.set('n', '<leader>uh', function()
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end
end, { desc = 'Toggle Inlay Hints' })

-- Snacks ecosystem keymaps
vim.keymap.set('n', '<leader>uz', function()
  require('snacks').zen()
end, { desc = 'Toggle Zen Mode' })
vim.keymap.set('n', '<leader>uZ', function()
  require('snacks').zen.zoom()
end, { desc = 'Toggle Zoom' })
vim.keymap.set('n', '<leader>uD', function()
  require('snacks').dim()
end, { desc = 'Toggle Dim' })
vim.keymap.set('n', '<leader>ua', function()
  require('snacks').animate.toggle()
end, { desc = 'Toggle Animations' })
vim.keymap.set('n', '<leader>ug', function()
  require('snacks').indent()
end, { desc = 'Toggle Indent Guides' })
vim.keymap.set('n', '<leader>uS', function()
  require('snacks').scroll()
end, { desc = 'Toggle Scroll' })

-- Ensure inlay hints are enabled for Nix files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'nix',
  callback = function()
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})

-- Configure system clipboard integration for Wayland
if vim.fn.executable 'wl-copy' == 1 then
  vim.g.clipboard = {
    name = 'wl-clipboard',
    copy = {
      ['+'] = { 'wl-copy', '--type', 'text/plain' },
      ['*'] = { 'wl-copy', '--primary', '--type', 'text/plain' },
    },
    paste = {
      ['+'] = { 'wl-paste', '--type', 'text/plain' },
      ['*'] = { 'wl-paste', '--primary', '--type', 'text/plain' },
    },
  }
elseif vim.fn.executable 'xclip' == 1 then
  -- Fallback to xclip if wl-clipboard not available
  vim.g.clipboard = {
    name = 'xclip',
    copy = {
      ['+'] = { 'xclip', '-selection', 'clipboard' },
      ['*'] = { 'xclip', '-selection', 'primary' },
    },
    paste = {
      ['+'] = { 'xclip', '-selection', 'clipboard', '-o' },
      ['*'] = { 'xclip', '-selection', 'primary', '-o' },
    },
  }
end

-- Other global options can go here
