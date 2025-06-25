-- Force nixd as the Nix language server and override LazyVim's nil preference
return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      lspconfig.nixd.setup {
        cmd = { 'nixd' },
        filetypes = { 'nix' },
        settings = {
          nixd = {
            nixpkgs = {
              expr = 'import <nixpkgs> { }',
            },
            formatting = {
              command = { 'nixfmt-classic' },
            },
          },
        },
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'nix',
        callback = function(args)
          -- Stop any nil_ls clients that might have started
          local clients = vim.lsp.get_clients { bufnr = args.buf }
          for _, client in ipairs(clients) do
            if client.name == 'nil_ls' then
              vim.lsp.stop_client(client.id)
            end
          end

          -- Check if nixd is already attached to this buffer
          local nixd_attached = false
          for _, client in ipairs(clients) do
            if client.name == 'nixd' then
              nixd_attached = true
              break
            end
          end

          -- Only attach if not already attached
          if not nixd_attached then
            -- Use buf_attach_client to attach the existing nixd client
            local all_clients = vim.lsp.get_clients { name = 'nixd' }
            if #all_clients > 0 then
              -- Reuse existing nixd client
              vim.lsp.buf_attach_client(args.buf, all_clients[1].id)
            else
              -- Start nixd if no client exists (this should rarely happen since we set it up above)
              vim.cmd 'LspStart nixd'
            end
          end
        end,
      })
    end,
  },
}
