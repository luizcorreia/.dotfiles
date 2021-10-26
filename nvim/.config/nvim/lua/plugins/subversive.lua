local u = require("utils")

local opts = { noremap = false }

-- s for substitute
u.map("n", "<Leader>s", "<Plug>(SubversiveSubstitute)", opts)
u.map("x", "<Leader>s", "<Plug>(SubversiveSubstitute)", opts)
u.map("n", "<Leader>ss", "<Plug>(SubversiveSubstituteLine)", opts)
u.map("n", "<Leader>S", "<Plug>(SubversiveSubstituteToEndOfLine)", opts)

-- substitute word in 1st motion over 2nd motion
u.map("n", "<Leader>r", "<Plug>(SubversiveSubstituteRange)", opts)
u.map("x", "<Leader>r", "<Plug>(SubversiveSubstituteRange)", opts)
-- substitute current word over motion
u.map("n", "<Leader>rr", "<Plug>(SubversiveSubstituteWordRange)", opts)
