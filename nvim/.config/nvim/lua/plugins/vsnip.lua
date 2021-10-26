local u = require("utils")

vim.g.vsnip_filetypes = {
    javascriptreact = { "javascript" },
    typescriptreact = { "typescript" },
}

u.nmap("<Leader>V", ":VsnipOpenVsplit<CR>")
