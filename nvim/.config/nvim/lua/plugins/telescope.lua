local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- Telescope Global remapping
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    winblend = 20,
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
    -- https://gitter.im/nvim-telescope/community?at=6113b874025d436054c468e6 Fabian David Schmidt
    find_files = {
      on_input_filter_cb = function(prompt)
        local find_colon = string.find(prompt, ":")
        if find_colon then
          local ret = string.sub(prompt, 1, find_colon - 1)
          vim.schedule(function()
            local prompt_bufnr = vim.api.nvim_get_current_buf()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local lnum = tonumber(prompt:sub(find_colon + 1))
            if type(lnum) == "number" then
              local win = picker.previewer.state.winid
              local bufnr = picker.previewer.state.bufnr
              local line_count = vim.api.nvim_buf_line_count(bufnr)
              vim.api.nvim_win_set_cursor(win, { math.max(1, math.min(lnum, line_count)), 0 })
            end
          end)
          return { prompt = ret }
        end
      end,
      attach_mappings = function()
        actions.select_default:enhance({
          post = function()
            -- if we found something, go to line
            local prompt = action_state.get_current_line()
            local find_colon = string.find(prompt, ":")
            if find_colon then
              local lnum = tonumber(prompt:sub(find_colon + 1))
              vim.api.nvim_win_set_cursor(0, { lnum, 0 })
            end
          end,
        })
        return true
      end,
    },
  },
})

map(
  "n",
  "<leader>p",
  '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<cr>'
)
map("n", "<leader>r", '<cmd>lua require("telescope.builtin").registers()<cr>')
map(
  "n",
  "<leader>g",
  '<cmd>lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<cr>'
)
map("n", "<leader>b", '<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({}))<cr>')
map("n", "<leader>j", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
map(
  "n",
  "<leader>f",
  '<cmd>lua require("telescope.builtin").file_browser(require("telescope.themes").get_dropdown({}))<cr>'
)
map("n", "<leader>s", '<cmd>lua require("telescope.builtin").spell_suggest()<cr>')
map(
  "n",
  "<leader>i",
  '<cmd>lua require("telescope.builtin").git_status(require("telescope.themes").get_dropdown({}))<cr>'
)
