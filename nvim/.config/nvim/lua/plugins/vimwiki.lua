local u = require 'utils'

u.lua_command('MakeDiaryEntry', 'lcee.make_diary_entry()')
u.lua_command('MakeTodo', 'lcee.make_todo()')
u.map('n', '<Leader>wd', '<cmd>MakeDiaryEntry<CR>')
u.map('n', '<Leader>wt', '<cmd>MakeTodo<CR>')

-- vim.api.nvim_set_keymap("n", "<leader>wd", '<cmd>lua R("wiki").make_diary_entry()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>wt", '<cmd>lua R("wiki").make_todo()<CR>', { noremap = true })
vim.g.vimwiki_list = { { path = '~/Dropbox/wiki', syntax = 'markdown', ext = '.wiki' } }

-- vim.g.vimwiki_ext2syntax = { '.md': 'markdown' }
vim.g.vimwiki_markdown_link_ext = 1

vim.g.taskwiki_markup_syntax = 'markdown'
vim.g.markdown_folding = 1
