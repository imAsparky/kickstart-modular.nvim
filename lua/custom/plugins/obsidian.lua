return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = 'Dunwright-Dev',
        path = '/mnt/g/My Drive/_Dunwright/Obsidian/Dunwright-Dev/',
      },
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    mappings = {
      -- Obsidian follow
      ['<leader>og'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = {
          noremap = false,
          expr = true,
          buffer = true,
        },
      },
      -- Toggle check-boxes "obsidian done"
      ['<leader>od'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },
    note_frontmatter_func = function(note)
      -- This is the equivalent to the default frontmatter function, with the area and project added.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = '', project = '' }
      -- 'note.metadata' containd any manual added fields in the frontmatter.
      --  Seo here we just make sure those fieldss are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    templates = {
      subdir = 'Templates',
      date_format = '%d-%m-%Y-%a',
      time_format = '%H:%M',
      tags = '',
    },
  },
}
