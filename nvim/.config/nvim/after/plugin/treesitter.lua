local custom_captures = {
  ["function.call.lua"] = "LuaFunctionCall",
  ["function.bracket"] = "Type",
  ["namespace.type"] = "TSNamespaceType",
}

require('nvim-treesitter.configs').setup {
  indent = { enable = true },
  highlight = {
    enable = true,
    use_languagetree = false,
    custom_captures = custom_captures,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  ensure_installed = {
    'go',
    'html',
    'markdown',
    'rust',
    'javascript',
    'typescript',
    'tsx',
    'lua',
    'json',
    'jsonc',
    'yaml',
  },
  -- plugins
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" }, -- optional, list of language that will be disabled
    -- [options]
  },
  autopairs = { enable = true },
  context_commentstring = {
    enable = true,
    -- With Comment.nvim, we don't need to run this on the autocmd.
    -- Only run it in pre-hook
    enable_autocmd = false,

    config = {
      c = "// %s",
      lua = "-- %s",
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}
