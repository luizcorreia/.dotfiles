local u = require 'utils'

u.nmap('<BS>', '<C-^>')

u.nmap('<Esc>', ':nohl<CR>')

u.nmap('<Tab>', '%', { noremap = false })
u.xmap('<Tab>', '%', { noremap = false })
u.omap('<Tab>', '%', { noremap = false })

u.imap('<S-Tab>', '<Esc>A')
u.nmap('<S-CR>', ':wqall<CR>')

u.nmap('H', '^')
u.omap('H', '^')
u.xmap('H', '^')
u.nmap('L', '$')
u.omap('L', '$')
u.xmap('L', '$')

-- tabs and splits
u.nmap('<Leader>cn', ':tabnew<CR>')
u.nmap('<Leader>ce', ':tabedit %<CR>')
u.nmap('<Leader>cc', ':tabclose<CR>')
u.nmap('<Leader>co', ':tabonly<CR>')
u.nmap('<Leader>vv', ':vsplit #<CR>')
-- misc
u.xmap('>', '>gv')
u.xmap('<', '<gv')

u.nmap('n', 'nzz')
u.nmap('N', 'Nzz')

-- Best map ever, thanks @mhartington
for i = 1, 9 do
  u.map('n', '<leader>' .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ')<CR>')
  u.map('t', '<leader>' .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ')<CR>')
end

u.map('n', '<Leader>u', '<cmd>PackerUpdate<cr>')
