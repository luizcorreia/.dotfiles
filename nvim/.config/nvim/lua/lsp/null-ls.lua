local null_ls = require 'null-ls'
local b = null_ls.builtins

local sources = {
  spectral = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = {
      'json',
      'yaml',
    },
    generator = null_ls.formatter {
      to_stdin = true,
      ignore_stderr = true,
      command = 'spectral',
      args = {
        'lint',
      },
    },
  },
  b.formatting.prettier.with {
    filetypes = {
      'html',
      'json',
      'yaml',
      'markdown',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
  },
  b.formatting.stylua.with {
    condition = function(utils)
      return utils.root_has_file 'stylua.toml'
    end,
  },
  -- b.formatting.stylua,
  -- b.formatting.eslint_d.with({
  -- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- condition = function(utils)
  -- return utils.root_has_file(".git") or utils.root_has_file(".eslintrc")
  -- end,
  -- }),

  b.formatting.trim_whitespace.with { filetypes = { 'tmux', 'teal', 'zsh' } },
  b.formatting.shfmt,
  b.diagnostics.write_good,
  b.diagnostics.markdownlint.with { filetypes = { 'markdown', 'vimwiki' } },
  b.diagnostics.teal,
  b.diagnostics.shellcheck.with { diagnostics_format = '#{m} [#{c}]' },
  -- b.code_actions.gitsigns,
  b.hover.dictionary,
}

local M = {}
M.setup = function(on_attach)
  null_ls.config {
    -- debug = true,
    sources = sources,
  }
  require('lspconfig')['null-ls'].setup { on_attach = on_attach }
end

return M
