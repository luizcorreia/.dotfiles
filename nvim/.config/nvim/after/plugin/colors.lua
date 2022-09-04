require('colorizer').setup()
vim.o.termguicolors = true
-- Load the colorscheme
-- vim.cmd [[colorscheme nord]]
-- vim.cmd 'hi Comment gui=italic'
-- vim.cmd 'hi Keyword gui=italic'
-- vim.cmd 'hi Identifier gui=italic'
vim.cmd 'hi StorageClass gui=italic'
vim.cmd 'hi jsLineComment gui=italic'
vim.cmd 'hi xmlAttrib gui=italic'
vim.cmd 'hi htmlArg gui=italic'
vim.cmd 'hi pythonSelf gui=italic'

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true
