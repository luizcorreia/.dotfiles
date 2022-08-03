-- highlight on yank
vim.cmd 'autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })'

-- BASH - Auto preenche arquivos .sh que não existirem com a SheBang
vim.cmd [[ autocmd BufNewFile *.sh :call append(0, '#!/usr/bin/env bash') ]]

-- always start terminals in insert mode
vim.cmd 'autocmd TermOpen * startinsert'
