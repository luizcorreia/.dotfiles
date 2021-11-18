local telescope = require 'telescope'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'
local themes = require 'telescope.themes'

local u = require 'utils'
local commands = require 'commands'

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

telescope.load_extension 'fzf'
telescope.load_extension 'git_worktree'

global.telescope = {
  refactors = function()
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
  end,

  git_branches = function()
    require('telescope.builtin').git_branches {
      attach_mappings = function(_, map)
        map('i', '<c-d>', actions.git_delete_branch)
        map('n', '<c-d>', actions.git_delete_branch)
        return true
      end,
    }
  end,

  git_files = function()
    local path = vim.fn.expand '%:h'
    if path == '' then
      path = nil
    end

    local width = 0.25
    if path and string.find(path, 'sourcegraph.*sourcegraph', 1, false) then
      width = 0.5
    end

    local opts = themes.get_dropdown {
      winblend = 5,
      previewer = false,
      shorten_path = false,

      cwd = path,

      layout_config = {
        width = width,
      },
    }
    require('telescope.builtin').git_files(opts)
  end,
  -- try git_files and fall back to find_files
  find_files = function()
    local set = require 'telescope.actions.set'
    local builtin = require 'telescope.builtin'

    local opts = {
      attach_mappings = function(_, map)
        map('i', '<C-v>', function(prompt_bufnr)
          set.edit(prompt_bufnr, 'vsplit')
        end)

        -- edit file and matching test file in split
        map('i', '<C-f>', function(prompt_bufnr)
          set.edit(prompt_bufnr, 'edit')
          commands.edit_test_file 'vsplit $FILE | wincmd w'
        end)

        return true
      end,
    }

    local is_git_project = pcall(global.telescope.git_files, opts)
    if not is_git_project then
      builtin.find_files(opts)
    end
  end,
  file_browser = function()
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
  end,
}

u.lua_command('Files', 'global.telescope.find_files()')
u.lua_command('FileBrowser', 'global.telescope.file_browser()')
u.command('Rg', 'Telescope live_grep')
u.command('BLines', 'Telescope current_buffer_fuzzy_find')
u.command('History', 'Telescope oldfiles')
u.command('BCommits', 'Telescope git_bcommits')
u.command('Commits', 'Telescope git_commits')
u.command('GStatus', 'Telescope git_status')
u.command('HelpTags', 'Telescope help_tags')
u.command('ManPages', 'Telescope man_pages')
u.lua_command('GBranches', 'global.telescope.git_branches()')
u.lua_command('Refactor', 'global.telescope.refactors()')

-- Files
u.map('n', '<Leader>ff', '<cmd>Files<CR>')
u.map('n', '<Leader>fg', '<cmd>Rg<CR>')
u.map('n', '<Leader>fo', '<cmd>History<CR>')
u.map('n', '<Leader>sb', '<cmd>BLines<CR>')
u.map('n', '<Leader>fc', '<cmd>BCommits<CR>')
u.map('n', '<Leader>fs', '<cmd>LspSym<CR>')
u.map('n', '-', '<cmd>FileBrowser<CR>')

-- Git
u.map('n', '<Leader>gb', '<cmd>GBranches<CR>')
u.map('n', '<Leader>gc', '<cmd>Commits<CR>')
u.map('n', '<Leader>gs', '<cmd>GStatus<CR>')

-- Git Worktree
u.map('n', '<Leader>gw', "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
u.map('n', '<Leader>gm', "<cmd>:lua require('telescope').extensions.git_worktree.create.git_worktrees()<CR>")

-- Nvim
u.map('n', '<Leader><space>', '<cmd>Buffers<CR>')
u.map('n', '<Leader>fh', '<cmd>HelpTags<CR>')

-- lsp
u.command('LspRef', 'Telescope lsp_references')
u.command('LspDef', 'Telescope lsp_definitions')
u.command('LspSym', 'Telescope lsp_workspace_symbols')
u.command('LspAct', 'Telescope lsp_code_actions')
