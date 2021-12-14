-- Telescope 🔭 - setup and customized pickers
require 'lcee.telescope.mappings'
local telescope = require 'telescope'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local utils = require 'telescope.utils'

local function refactor(prompt_bufnr)
  local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
  require('telescope.actions').close(prompt_bufnr)
  require('refactoring').refactor(content.value)
end

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == 'table' then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local function generateOpts(opts)
  local common_opts = {
    layout_strategy = 'center',
    sorting_strategy = 'ascending',
    results_title = false,
    preview_title = 'Preview',
    previewer = false,
    layout_config = {
      width = 80,
      height = 15,
    },
    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
      results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
      preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },
  }
  return vim.tbl_extend('force', opts, common_opts)
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

telescope.load_extension 'git_worktree'
telescope.load_extension 'node_modules'
telescope.load_extension 'octo'

-- 🔭 Extensions --
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require('telescope').load_extension 'file_browser'
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim#telescope-fzf-nativenvim
require('telescope').load_extension 'fzf'

-- https://github.com/dhruvmanila/telescope-bookmarks.nvim
-- <space>b
-- require('telescope').load_extension 'bookmarks'

-- https://github.com/cljoly/telescope-repo.nvim
-- <leader>rl
require('telescope').load_extension 'repo'

-- https://github.com/AckslD/nvim-neoclip.lua
-- <C-n>
require('telescope').load_extension 'neoclip'

-- GitHub CLI → local version
require('telescope').load_extension 'gh'

-- my telescopic customizations
local M = {}

function M.repo_list()
  local opts = {}
  opts.prompt_title = '  Repos'
  telescope.extensions.repo.list(opts)
end

-- requires GitHub extension
function M.gh_issues()
  local opts = {}
  opts.prompt_title = ' Issues'
  telescope.extensions.gh.issues(opts)
end

function M.gh_prs()
  local opts = {}
  opts.prompt_title = ' Pull Requests'
  require('telescope').extensions.gh.pull_request(opts)
end
-- end github functions

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

-- search Neovim related todos
function M.search_todos()
  require('telescope.builtin').grep_string {
    prompt_title = '  Search TODOUAs',
    prompt_prefix = '  ',
    results_title = 'Neovim TODOUAs',
    path_display = { 'smart' },
    search = 'TODOUA',
  }
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

function M.find_configs()
  require('telescope.builtin').find_files {
    prompt_title = ' NVim & Term Config Find',
    results_title = 'Config Files Results',
    path_display = { 'smart' },
    search_dirs = {
      '~/.dotfiles',
      '~/.config/nvim',
      '~/.config/alacritty',
    },
    -- cwd = "~/.config/nvim/",
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.nvim_config()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = ' NVim Config Browse',
    cwd = '~/.config/nvim/',
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.refactors()
  require('telescope.pickers').new({}, {
    prompt_title = 'refactors',
    finder = require('telescope.finders').new_table {
      results = require('refactoring').get_refactors(),
    },
    sorter = require('telescope.config').values.generic_sorter {},
    attach_mappings = function(_, map)
      map('i', '<CR>', refactor)
      map('n', '<CR>', refactor)
      return true
    end,
  }):find()
end

function M.git_branches()
  require('telescope.builtin').git_branches {
    attach_mappings = function(_, map)
      map('i', '<c-d>', actions.git_delete_branch)
      map('n', '<c-d>', actions.git_delete_branch)
      return true
    end,
  }
end

function M.file_explorer()
  require('telescope').extensions.file_browser.file_browser {
    prompt_title = '  File Browser',
    path_display = { 'smart' },
    cwd = '~',
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 0.65, width = 0.75 },
  }
end

function M.file_browser()
  local opts

  opts = {
    sorting_strategy = 'ascending',
    scroll_strategy = 'cycle',
    layout_config = {
      prompt_position = 'top',
    },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        current_picker.cwd = new_cwd
        current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
      end

      map('i', '-', function()
        modify_cwd(current_picker.cwd .. '/..')
      end)

      map('i', '~', function()
        modify_cwd(vim.fn.expand '~')
      end)

      local modify_depth = function(mod)
        return function()
          opts.depth = opts.depth + mod

          local this_picker = action_state.get_current_picker(prompt_bufnr)
          this_picker:refresh(opts.new_finder(current_picker.cwd), { reset_prompt = true })
        end
      end

      map('i', '<M-=>', modify_depth(1))
      map('i', '<M-+>', modify_depth(-1))

      map('n', 'yy', function()
        local entry = action_state.get_selected_entry()
        vim.fn.setreg('+', entry.value)
      end)

      return true
    end,
  }

  require('telescope.builtin').file_browser(opts)
end

return M
