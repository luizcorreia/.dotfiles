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

map("n", "<Leader><CR>", "<cmd>so ~/.config/nvim/init.lua<cr>")

-- Telescope
map("n", "<C-p>", '<cmd>lua require("telescope.builtin").git_files()<cr>')
map("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>')
map("n", "<leader>fr", '<cmd>lua require("telescope.builtin").registers()<cr>')
map("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
map("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>')
map("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map("n", "<leader>s", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')
map("n", "<leader>i", '<cmd>lua require("telescope.builtin").git_status()<cr>')
map("n", "<Leader>gw", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>")
map("n", "<Leader>gm", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>")
map("n", "<Leader>fm", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>")

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

-- Open split terminal
map("n", "<Leader>t", ":split | resize 15 | term<CR>", { silent = true })

map("x", "<Leader>p", '"_dP')
map("n", "<Leader>y", '"+y')
map("v", "<Leader>y", '"+y')
map("n", "<Leader>Y", 'gg"+yG')

-- Lsp
map("n", "<leader>vd", ":lua vim.lsp.buf.definition()<CR>", { silent = true })
map("n", "<leader>vi", ":lua vim.lsp.buf.implementation()<CR>", { silent = true })
map("n", "<leader>vsh", ":lua vim.lsp.buf.signature_help()<CR>", { silent = true })
map("n", "<leader>vrr", ":lua vim.lsp.buf.references()<CR>", { silent = true })
map("n", "<leader>vrn", ":lua vim.lsp.buf.rename()<CR>", { silent = true })
map("n", "<leader>vh", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
map("n", "<leader>vca", ":lua vim.lsp.buf.code_action()<CR>", { silent = true })
map(
  "n",
  "<leader>vsd",
  ":lua vim.lsp.diagnostic.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>",
  { silent = true }
)
map("n", "<leader>vn", ":lua vim.lsp.diagnostic.goto_next()<CR>", { silent = true })
map("n", "<leader>vll", ":call LspLocationList()<CR>", { silent = true })

map("n", "<Leader>cf", ":Lspsaga lsp_finder<CR>", { silent = true })
map("n", "<leader>ca", ":Lspsaga code_action<CR>", { silent = true })
map("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { silent = true })
map("n", "<leader>ch", ":Lspsaga hover_doc<CR>", { silent = true })
map("n", "<leader>ck", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })
map("n", "<leader>cj", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
map("n", "<leader>cs", ":Lspsaga signature_help<CR>", { silent = true })
map("n", "<leader>ci", ":Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "<leader>cn", ":Lspsaga diagnostic_jump_next<CR>", { silent = true })
map("n", "<leader>cp", ":Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "<leader>cr", ":Lspsaga rename<CR>", { silent = true })
map("n", "<leader>cd", ":Lspsaga preview_definition<CR>", { silent = true })
