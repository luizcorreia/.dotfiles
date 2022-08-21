local null_ls = require 'null-ls'
local b = null_ls.builtins

local with_root_file = function(...)
  local files = { ... }
  return function(utils)
    return utils.root_has_file(files)
  end
end

local severities = { 1, 2, 3, 4 }

local spectral = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = {
    'json',
    'yaml',
  },
  id = 42,
  generator = null_ls.generator {
    to_stdin = true,
    ignore_stderr = true,
    use_cache = true,
    command = 'spectral',
    args = {
      'lint',
      '--stdin-filepath',
      '-f',
      'json',
    },
    format = 'json',
    -- from_stderr = true,
    check_exit_code = function(code)
      return code <= 1
    end,
    on_output = function(params)
      local diags = {}
      for _, d in ipairs(params.output) do
        table.insert(diags, {
          row = d.range.start.line + 1,
          col = d.range.start.character + 1,
          end_row = d.range["end"].line + 1,
          end_col = d.range["end"].character + 1,
          source = "Spectral",
          message = d.message,
          severity = severities[d.severity + 1],
          code = d.code,
          path = d.path,
        })
      end
      return diags
    end,
  },
}

null_ls.register(spectral)

local sources = {
  -- formatting
  b.formatting.prettier,
  b.formatting.fish_indent,
  b.formatting.shfmt,
  b.formatting.clang_format,
  b.formatting.trim_whitespace.with({
    filetypes = { "tmux", "snippets" },
  }),
  b.formatting.stylua.with({
    condition = with_root_file("stylua.toml"),
  }),
  -- diagnostics
  b.diagnostics.selene.with({
    condition = with_root_file("selene.toml"),
  }),
  b.diagnostics.write_good,
  b.diagnostics.markdownlint,
  -- code actions
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,
  -- hover
  b.hover.dictionary,
}

local M = {}
M.setup = function(on_attach)
  if not vim.g.started_by_firenvim then
    null_ls.setup({
      debug = true,
      sources = sources,
      on_attach = on_attach,
    })
  end
end

return M
