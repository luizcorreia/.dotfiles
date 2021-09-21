if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> <C-p> <cmd>Telescope git_files<cr>
nnoremap <silent> <Space>pf <cmd>Telescope find_files<cr>
nnoremap <silent> <Space>pb <cmd>Telescope buffers<cr>
nnoremap <silent> <Space>; <cmd>Telescope help_tags<cr>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF

