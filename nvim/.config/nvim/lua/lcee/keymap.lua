local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c", 

-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

keymap('n', '<leader>-', ':Lex 30<cr>', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Tabs and splits
keymap('n', '<leader>cn', ':tabnew<CR>', opts)
keymap('n', '<leader>ce', ':tabedit %<CR>', opts)
keymap('n', '<leader>cc', ':tabclose<CR>', opts)
keymap('n', '<leader>co', ':tabonly<CR>', opts)
keymap('n', '<leader>vv', ':vsplit #<CR>', opts)

-- Misc
-- Keep search results centred
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', 'J', 'mzJ`z', opts)
-- Insert a newline in normal mode
keymap('n', '<leader>o', 'm`o<Esc>``', opts)

-- Best map ever
for i = 1, 9 do
    keymap('n', '<leader>' .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ')<CR>', opts)
    keymap('t', '<leader>' .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ')<CR>', opts)
end

-- Nvim
-- keymap('n', '<Leader><space>', '<cmd>Buffers<CR>')

-- Insert --
-- Press jk fast to enter
keymap('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('v', 'p', '"_dP', opts)

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
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Make visual yanks place the cursor back where started
keymap('v', 'y', 'ygv<Esc>', opts)
-- Misc
keymap('x', '>', '>gv', opts)
keymap('x', '<', '<gv', opts)

-- Terminal --
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- MISC --
keymap('x', '<Leader>p', '"_dP',opts)
keymap('n', '<Leader>y', '"+y',opts)
keymap('v', '<Leader>y', '"+y',opts)
keymap('n', '<Leader>Y', 'gg"+yG',opts)

keymap('n', '<Leader>d', '"_d',opts)
keymap('v', '<Leader>d', '"_d',opts)
