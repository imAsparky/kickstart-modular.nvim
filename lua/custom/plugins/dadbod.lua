return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    -- Debug prints before setting
    print('LOCAL_DATABASE_URL:', vim.fn.getenv 'LOCAL_DATABASE_URL')
    print('STAGING_DATABASE_URL:', vim.fn.getenv 'STAGING_DATABASE_URL')
    print('TESTING_DATABASE_URL:', vim.fn.getenv 'TESTING_DATABASE_URL')

    -- Set connections including SQLite
    vim.g.dbs = {
      local_db = vim.fn.getenv 'LOCAL_DATABASE_URL',
      staging_db = vim.fn.getenv 'STAGING_DATABASE_URL',
      testing_db = vim.fn.getenv 'TESTING_DATABASE_URL',
      sqlite = 'sqlite:' .. vim.fn.getcwd() .. '/db.sqlite3',
    }

    -- Debug print after setting
    print 'Final dbs configuration:'
    print(vim.inspect(vim.g.dbs))
  end,
}
