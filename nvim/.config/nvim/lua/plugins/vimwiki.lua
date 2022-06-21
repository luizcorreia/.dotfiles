local u = require 'utils'
local wiki = require 'lcee.wiki'

u.lua_command('MakeDiaryEntry', 'wiki.make_diary_entry()')
u.lua_command('MakeTodo', 'wiki.make_todo()')
u.map('n', '<Leader>wd', '<cmd>MakeDiaryEntry()<CR>')
u.map('n', '<Leader>t', '<cmd>MakeTodo()<CR>')

-- vim.api.nvim_set_keymap("n", "<leader>wd", '<cmd>lua R("wiki").make_diary_entry()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>wt", '<cmd>lua R("wiki").make_todo()<CR>', { noremap = true })
vim.g.vimwiki_list = { { path = '~/Documents/wiki', syntax = 'markdown', ext = '.wiki' } }
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_ext2syntax = {
  ['.wiki'] = 'markdown',
  ['.md'] = 'markdown',
  ['.markdown'] = 'markdown',
  ['.mdown'] = 'markdown',
}
