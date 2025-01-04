-- https://www.youtube.com/watch?v=_YaI2vDbk0o
return {
  'christoomey/vim-tmux-navigator',
  vim.keymap.set('n', 'C-h', ':TmuxNavigateLeft<CR>'),
  vim.keymap.set('n', 'C-j', ':TmuxNavigateDown<CR>'),
  vim.keymap.set('n', 'C-k', ':TmuxNavigateUp:<CR>'),
  vim.keymap.set('n', 'C-l', ':TmuxNavigateRight<CR>'),
}
