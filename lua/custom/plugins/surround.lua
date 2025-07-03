return {
  'tpope/vim-surround',
  event = { 'BufReadPre', 'BufNewFile' },
  version = '*', -- Use latest stable version
  keys = {
    { 'ys', desc = 'Add surrounding' },
    { 'ds', desc = 'Delete surrounding' },
    { 'cs', desc = 'Change surrounding' },
    { 'S', mode = 'v', desc = 'Add surrounding to visual selection' },
  },
}
