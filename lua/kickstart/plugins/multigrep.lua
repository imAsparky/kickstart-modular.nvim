-- from TJ https://youtu.be/xdXE1tOT-qg?si=fwMSLOXDO4of6-hT

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values

local M = {}
local live_multigrep = function()
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local pieces = vim.split(prompt, '  ') -- use double space to separate the search terms
      local args = { 'rg' } -- using ripgrep here.
      if pieces[1] then
        table.insert(args, '-e') -- tell ripgrep what we are searching for -e
        table.insert(args, pieces[1])
      end
      if pieces[2] then
        table.insert(args, '-g') -- tell ripgrep to glob/filter files -g
        table.insert(args, pieces[2])
      end

      return vim.list_extend(args, { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }
  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Multi Grep',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(), -- dont sort it
    })
    :find()
end
M.setup = function()
  vim.keymap.set('n', '<leader>sm', live_multigrep, { desc = '[S]earch [M]ultigrep' })
end
return M
