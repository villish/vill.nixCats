return {
  {
    'LazyVim',
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd('VimEnter', {
        pattern = '*',
        callback = function()
          vim.opt.timeoutlen = 500
        end,
      })
    end,
  },
}
