local telescope = require 'telescope'
local utils = require 'telescope.utils'
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " >",
		color_devicons = true,

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
			},
		},
	},
    --[[
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
    ]]
})

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == 'table' then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

telescope.setup {
  extensions = {
    fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true },
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },

    fzf_writer = {
      use_highlighter = false,
      minimum_grep_characters = 6,
    },
  },
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--ignore',
      '--hidden',
      '-g',
      '!.git',
    },
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',

    winblend = 0,

    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = 'top',

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    scroll_strategy = 'cycle',
    color_devicons = true,
    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-n>'] = 'move_selection_next',

        ['<C-y>'] = set_prompt_to_entry_value,

        -- ["<M-m>"] = actions.master_stack,

        -- Experimental
        -- ["<tab>"] = actions.toggle_selection,

        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ['<C-space>'] = function(prompt_bufnr)
          local opts = {
            callback = actions.toggle_selection,
            loop_callback = actions.send_selected_to_qflist,
          }
          require('telescope').extensions.hop._hop_loop(prompt_bufnr, opts)
        end,
      },
    },
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

    -- file_sorter = sorters.get_fzy_sorter,
    file_ignore_patterns = {
      -- "parser.c",
      -- "mock_.*.go",
    },

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },
}

require("telescope").load_extension("git_worktree")
-- require('telescope').load_extension 'neoclip'

local M = {}

function M.repo_list()
  local opts = {}
  opts.prompt_title = '  Repos'
  telescope.extensions.repo.list(opts)
end

-- grep_string pre-filtered from grep_prompt
local function grep_filtered(opts)
  opts = opts or {}
  require('telescope.builtin').grep_string {
    path_display = { 'smart' },
    search = opts.filter_word or '',
  }
end

-- open vim.ui.input dressing prompt for initial filter
function M.grep_prompt()
  vim.ui.input({ prompt = 'Rg  ' }, function(input)
    grep_filtered { filter_word = input }
  end)
end

M.project_files = function()
  local _, ret, stderr = utils.get_os_command_output {
    'git',
    'rev-parse',
    '--is-inside-work-tree',
  }

  local gopts = {}
  local fopts = {}

  gopts.prompt_title = '  Find'
  gopts.prompt_prefix = '   '
  gopts.results_title = '  Repo Files'

  fopts.hidden = true
  fopts.file_ignore_patterns = {
    '.vim/',
    '.local/',
    '.cache/',
    'Downloads/',
    '.git/',
    'Dropbox/.*',
    'Library/.*',
    '.rustup/.*',
    'Movies/',
    '.cargo/registry/',
  }

  if ret == 0 then
    require('telescope.builtin').git_files(gopts)
  else
    fopts.results_title = 'CWD: ' .. vim.fn.getcwd()
    require('telescope.builtin').find_files(fopts)
  end
end

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end

local function refactor(prompt_bufnr)
	local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
	require("telescope.actions").close(prompt_bufnr)
	require("refactoring").refactor(content.value)
end

M.refactors = function()
	require("telescope.pickers").new({}, {
		prompt_title = "refactors",
		finder = require("telescope.finders").new_table({
			results = require("refactoring").get_refactors(),
		}),
		sorter = require("telescope.config").values.generic_sorter({}),
		attach_mappings = function(_, map)
			map("i", "<CR>", refactor)
			map("n", "<CR>", refactor)
			return true
		end,
	}):find()
end

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end,
	})
end

return M
