pcall(require, 'impatient')

if require 'lcee.first_load'() then
  return
end
-- initialize global object for config
global = {}

require 'options'
require 'lcee.mappings'
require 'plugins'
require 'lcee.disable_builtin'
require 'theme'
-- require("tmux")
require 'commands'
require 'lsp'
