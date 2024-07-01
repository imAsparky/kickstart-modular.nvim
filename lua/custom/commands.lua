-- kudos https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/#:~:text=Formatting%20on%20save%20is%20a,is%20very%20easy%20using%20autocmds%20.&text=We%20create%20a%20new%20autocmd,client%20attaches%20to%20a%20buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp', { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd('BufWritePre', {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format { async = false, id = args.data.client_id }
      end,
    })
  end,
})
