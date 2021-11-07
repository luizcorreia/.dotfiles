local u = require("utils")
require("options")


-- initialize global object for config
global = {}
-- mapneDownneDownks

-- make useless keys useful
u.nmap("<BS>", "<C-^>")

u.nmap("<Esc>", ":nohl<CR>")

u.nmap("<Tab>", "%", { noremap = false })
u.xmap("<Tab>", "%", { noremap = false })
u.omap("<Tab>", "%", { noremap = false })

u.imap("<S-Tab>", "<Esc>A")
u.nmap("<S-CR>", ":wqall<CR>")

u.nmap("H", "^")
u.omap("H", "^")
u.xmap("H", "^")
u.nmap("L", "$")
u.omap("L", "$")
u.xmap("L", "$")

-- tabs and splits
u.nmap("<Leader>cn", ":tabnew<CR>")
u.nmap("<Leader>ce", ":tabedit %<CR>")
u.nmap("<Leader>cc", ":tabclose<CR>")
u.nmap("<Leader>co", ":tabonly<CR>")
u.nmap("<Leader>vv", ":vsplit #<CR>")
-- misc
u.xmap(">", ">gv")
u.xmap("<", "<gv")

u.nmap("n", "nzz")
u.nmap("N", "Nzz")
-- automatically add jumps > 1 to jump list
-- u.nmap("k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], { expr = true }) u.nmap("j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], { expr = true })
-- source remaining config
require("theme")
-- require("tmux")
require("commands")
require("plugins")
require("lsp")
