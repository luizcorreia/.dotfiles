-- vim.fn["gina#custom#command#option"]('status', '--opener', 'vsplit')
-- nnoremap { '<leader>gs', '<cmd>Gina status<CR>' }

-- local ok, neogit = pcall(require, "neogit")
-- if not ok then
--   return
-- end

local neogit = require("neogit")
neogit.setup({})
vim.api.nvim_set_keymap("n", "<Leader>gs", [[<Cmd>lua require('neogit').open()<CR>]], {
  noremap = true,
  silent = true,
})
vim.api.nvim_set_keymap(
  "n",
  "<Leader>gc",
  [[<Cmd>lua require('neogit').open({'commit'})<CR>]],
  { noremap = true, silent = true }
)

-- map("n", "<Leader>gs", neogit.open)
-- map("n", "<Leader>gc", {
--   function()
--     neogit.open({ "commit" })
--   end,
-- })
