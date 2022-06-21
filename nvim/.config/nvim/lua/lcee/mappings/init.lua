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

u.map('n', '<Leader>up', '<cmd>PackerUpdate<cr>')

u.command('Rg', 'Telescope live_grep')
u.command('BLines', 'Telescope current_buffer_fuzzy_find')
u.command('History', 'Telescope oldfiles')
u.command('BCommits', 'Telescope git_bcommits')
u.command('Commits', 'Telescope git_commits')
u.command('GStatus', 'Telescope git_status')
u.command('HelpTags', 'Telescope help_tags')
u.command('ManPages', 'Telescope man_pages')
u.command('Colors', 'Telescope colorscheme')
u.command('Buffers', 'Telescope buffers')
u.lua_command('Refactor', "<cmd>:lua require('lcee.telescope').refactors()<CR>")

-- Files
u.map('n', '<Leader>ff', "<cmd>:lua require('lcee.telescope').project_files()<CR>")
u.map('n', '<Leader>fg', '<cmd>Rg<CR>')
u.map('n', '<Leader>fo', '<cmd>History<CR>')
u.map('n', '<Leader>sb', '<cmd>BLines<CR>')
u.map('n', '<Leader>pb', '<cmd>Buffers<CR>')
u.map('n', '<Leader>fc', '<cmd>BCommits<CR>')
u.map('n', '<Leader>fs', '<cmd>LspSym<CR>')
u.map('n', '-', "<cmd>:lua require('lcee.telescope').file_browser()<CR>")
u.map('n', '<Leader>c', '<cmd>Colors<CR>')
u.map('n', '<Leader>e', "<cmd>:lua require('lcee.telescope').find_configs()<CR>")
u.map('n', '<Leader>nc', "<cmd>:lua require('lcee.telescope').nvim_config()<CR>")
u.map('n', ',e', "<cmd>:lua require('lcee.telescope').file_explorer()<CR>")

-- Github
u.map('n', '<Leader>is', "<cmd>:lua require('lcee.telescope').gh_issues()<CR>")
u.map('n', '<Leader>pr', "<cmd>:lua require('lcee.telescope').gh_prs()<CR>")

-- Git
u.map('n', '<Leader>gb', "<cmd>:lua require('lcee.telescope').git_branches()<CR>")
u.map('n', '<Leader>gc', '<cmd>Commits<CR>')
u.map('n', '<Leader>gs', '<cmd>GStatus<CR>')
u.map('n', '<Leader>rl', "<cmd>:lua require('lcee.telescope').repo_list()<CR>")

-- Git Worktree
u.map('n', '<Leader>gw', "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
u.map('n', '<Leader>gm', "<cmd>:lua require('telescope').extensions.git_worktree.create.git_worktrees()<CR>")

-- Neoclip
u.map('n', '<C-n>', "<cmd>:lua require('telescope').extensions.neoclip.plus()<CR>")

-- Nvim
u.map('n', '<Leader><space>', '<cmd>Buffers<CR>')
u.map('n', '<Leader>fh', '<cmd>HelpTags<CR>')

-- lsp
u.command('LspRef', 'Telescope lsp_references')
u.command('LspDef', 'Telescope lsp_definitions')
u.command('LspSym', 'Telescope lsp_workspace_symbols')
u.command('LspAct', 'Telescope lsp_code_actions')
