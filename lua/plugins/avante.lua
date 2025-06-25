return {
  {
    'avante.nvim',
    event = 'VeryLazy', -- or "BufReadPost" if you want it earlier
    config = function()
      require('avante').setup {
        -- You can put your avante config here, or leave empty for defaults
      }
    end,
  },
}
