pcall(require, 'impatient')

local u = require 'utils'
require 'options'

if require 'lcee.first_load'() then
  return
end
-- initialize global object for config
global = {}
-- maps
-- make useless keys useful
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
-- automatically add jumps > 1 to jump list
-- u.nmap("k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], { expr = true }) u.nmap("j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], { expr = true })
-- source remaining config
-- Turn off builtin plugins I do not use.
require 'plugins'
require 'lcee.disable_builtin'
require 'theme'
-- require("tmux")
require 'commands'
require 'lsp'
