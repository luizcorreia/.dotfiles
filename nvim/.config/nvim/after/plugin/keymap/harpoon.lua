local u = require 'lcee.utils'

u.map('n', '<C-e>', "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>")
u.map('n', '<Leader>tc', "<cmd>lua require'harpoon.cmd-ui'.toggle_quick_menu()<cr>")
u.map('n', '<Leader>a', "<cmd>lua require'harpoon.mark'.add_file()<cr>")

u.map('n', '<C-h>', "<cmd>lua require'harpoon.ui'.nav_file(1)<CR>")
u.map('n', '<C-j>', "<cmd>lua require'harpoon.ui'.nav_file(2)<CR>")
u.map('n', '<C-k>', "<cmd>lua require'harpoon.ui'.nav_file(3)<CR>")
u.map('n', '<C-l>', "<cmd>lua require'harpoon.ui'.nav_file(4)<CR>")
