local u = require("utils")

u.map("n", "<M-n>", '<cmd> lua require"illuminate".next_reference{wrap=true}<CR>')
u.map("n", "<M-p>", '<cmd> lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>')
