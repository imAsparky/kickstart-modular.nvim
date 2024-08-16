-- These are mainly Neogit but also some Git settings
--  like fetching branches with telescope or blaming with fugitive
--  kudos to https://youtu.be/K-FKqXj8BAQ?si=J6qbMcXKmbNnSzLH for these

local neogit = require 'neogit'

vim.keymap.set('n', '<leader>gs', neogit.open, { silent = true, noremap = true })
vim.keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>gP', ':Neogit Push<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>gB', ':G blame<CR>', { silent = true, noremap = true })
