vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('FixStatusLineColors', { clear = true }),
  callback = function()
    local lualine_c = vim.api.nvim_get_hl(0, { name = 'lualine_c_normal' })
    if lualine_c.bg and lualine_c.fg then
      vim.api.nvim_set_hl(0, 'StatusLine', {
        bg = lualine_c.bg,
        fg = lualine_c.fg,
      })
    end
  end,
})

vim.schedule(function()
  local lualine_c = vim.api.nvim_get_hl(0, { name = 'lualine_c_normal' })
  if lualine_c.bg and lualine_c.fg then
    vim.api.nvim_set_hl(0, 'StatusLine', {
      bg = lualine_c.bg,
      fg = lualine_c.fg,
    })
  end
end)
