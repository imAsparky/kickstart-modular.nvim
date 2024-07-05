-- Custom vim options

-- NOTE: Allow nvim to use the bash aliases
vim.opt.shellcmdflag = '-ic'

-- Code folding options
-- vim.opt.foldmethod = 'manual'
vim.opt.foldcolumn = '1' -- Using 0 is not bad
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99 -- keeps folds open when changing buffers

-- setup conceallevel to enable it in obsidian.nvim
vim.opt.conceallevel = 1
