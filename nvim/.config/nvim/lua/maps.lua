local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<leader>c", "<cmd>lua require'luizcorreia.markdown'.ConvertFile()<cr>")
-- Hop
map("n", "<leader>h", "<cmd>lua require'hop'.hint_char2()<cr>")
map("n", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")
map("v", "<leader>h", "<cmd>lua require'hop'.hint_char2()<cr>")
map("v", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>")

-- Harpoon
map("n", "<C-e>", "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>")
map("n", "<Leader>a", "<cmd>lua require'harpoon.mark'.add_file()<cr>")
map("n", "<Leader>tu", "<cmd>lua require'harpoon.term'.gotoTerminal(1)()<cr>")
map("n", "<Leader>te", "<cmd>lua require'harpoon.term'.gotoTerminal(2)()<cr>")

map("n", "<Leader><CR>", "<cmd>so ~/.config/nvim/init.vim<cr>")

-- Telescope
map("n", "<C-p>", '<cmd>lua require("telescope.builtin").git_files()<cr>')
map("n", "<leader>pf", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map("n", "<leader>r", '<cmd>lua require("telescope.builtin").registers()<cr>')
map("n", "<leader>g", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map("n", "<leader>pb", '<cmd>lua require("telescope.builtin").buffers()<cr>')
map("n", "<leader>j", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map("n", "<leader>f", '<cmd>lua require("telescope.builtin").file_browser()<cr>')
map("n", "<leader>s", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')
map("n", "<leader>i", '<cmd>lua require("telescope.builtin").git_status()<cr>')
map("n", "<Leader>gw", "<code>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>")
map("n", "<Leader>gm", "<code>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>")

-- Open nvimrc file
map("n", "<Leader>v", "<cmd>e $MYVIMRC<CR>")

-- Source nvimrc file
map("n", "<Leader>sv", ":luafile %<CR>")

-- Quick new file
map("n", "<Leader>n", "<cmd>enew<CR>")

-- Easy select all of file
map("n", "<Leader>sa", "ggVG<c-$>")

-- Make visual yanks place the cursor back where started
map("v", "y", "ygv<Esc>")

-- Easier file save
map("n", "<Leader>w", "<cmd>:w<CR>")

-- Tab to switch buffers in Normal mode
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")

-- Insert a newline in normal mode
map("n", "<leader>o", "m`o<Esc>``")

-- More molecular undo of text
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ":", ":<c-g>u")

-- Keep search results centred
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- Make Y yank to end of the line
map("n", "Y", "y$")

-- Line bubbling
map("n", "<c-j>", "<cmd>m .+1<CR>==", { silent = true })
map("n", "<c-k>", "<cmd>m .-2<CR>==", { silent = true })
map("v", "<c-j>", ":m '>+1<CR>==gv=gv", { silent = true })
map("v", "<c-k>", ":m '<-2<CR>==gv=gv", { silent = true })

-- Toggle netrw
map("n", "<Leader>e", ":Lexplore<CR>", { silent = true })

--Auto close tags
map("i", ",/", "</<C-X><C-O>")

--After searching, pressing escape stops the highlight
map("n", "<esc>", ":noh<cr><esc>", { silent = true })

-- Toggle netrw
map("n", "<Leader>e", ":Lexplore<CR>", { silent = true })