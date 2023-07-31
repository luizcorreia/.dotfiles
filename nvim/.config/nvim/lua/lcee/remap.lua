local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
-- Best map ever
for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ')<CR>')
    vim.keymap.set('t', '<leader>' .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ')<CR>')
end

-- Vsual --
vim.keymap.set(
    'n',
  "<M-j>",
  function()
    if vim.opt.diff:get() then
      vim.cmd [[normal! ]c]]
    else
      vim.cmd [[m .+1<CR>==]]
    end
  end,
    opts
)

vim.keymap.set(
    'n',
  "<M-k>",
  function()
    if vim.opt.diff:get() then
      vim.cmd [[normal! [c]]
    else
      vim.cmd [[m .-2<CR>==]]
    end
  end,
    opts
)

-- Visual Block --
-- Move text up and down
vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv", opts)
vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv", opts)
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Make visual yanks place the cursor back where started
vim.keymap.set('v', 'y', 'ygv<Esc>', opts)
-- Misc
vim.keymap.set('x', '>', '>gv', opts)
vim.keymap.set('x', '<', '<gv', opts)

-- Terminal --
-- Better terminal navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- MISC --
vim.keymap.set('x', '<Leader>p', '"_dP',opts)
vim.keymap.set('n', '<Leader>y', '"+y',opts)
vim.keymap.set('v', '<Leader>y', '"+y',opts)
vim.keymap.set('n', '<Leader>Y', 'gg"+yG',opts)

vim.keymap.set('n', '<Leader>d', '"_d',opts)
vim.keymap.set('v', '<Leader>d', '"_d',opts)
