vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == 'Darwin' and 'open' or 'xdg-open'
vim.g.dotfiles = vim.env.DOTFILES or vim.fn.expand '~/.dotfiles'
vim.g.vim_dir = vim.g.dotfiles .. '/.config/nvim'

pcall(require, 'impatient')

if require 'lcee.first_load'() then
  return
end
-- initialize global object for config
global = {}

local ok, reload = pcall(require, 'plenary.reload')
RELOAD = ok and reload.reload_module or function(...)
  return ...
end
function R(name)
  RELOAD(name)
  return require(name)
end

R 'lcee.globals'
R 'lcee.settings'
R 'options'
R 'lcee.mappings'
R 'plugins'
R 'lcee.disable_builtin'
R 'theme'
-- R("tmux")
R 'commands'
R 'lsp'
