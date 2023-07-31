local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.fish_indent,
    -- null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.cfn_lint,
    null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.diagnostics.commitlint,
    null_ls.builtins.diagnostics.spectral,
    null_ls.builtins.completion.spell,
    require("typescript.extensions.null-ls.code-actions")
  }
})
