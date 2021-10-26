local u = require("utils")

require("gitsigns").setup()

u.nmap("<Leader>g", ":tab Git<CR>")
u.nmap("<Leader>G", ":Git ", { silent = false })

vim.cmd("autocmd FileType fugitive nmap <buffer> <Tab> =")
