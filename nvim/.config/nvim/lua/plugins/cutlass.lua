local u = require("utils")

local opts = { noremap = true }

-- m to "cut" (original delete operation)
u.map("n", "m", "d", opts)
u.map("x", "m", "d", opts)
u.map("n", "mm", "dd", opts)
u.map("n", "M", "D", opts)

-- gm for marks
u.map("n", "gm", "m", opts)
