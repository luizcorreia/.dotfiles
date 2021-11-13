require("indent_blankline").setup({
    show_current_context = true,
    show_end_of_line = true,
    -- space_char_blankline = " ",
    -- char_highlight_list = {
    --     "IndentBlanklineIndent1",
    --     "IndentBlanklineIndent2",
    --     "IndentBlanklineIndent3",
    --     "IndentBlanklineIndent4",
    --     "IndentBlanklineIndent5",
    --     "IndentBlanklineIndent6",
    -- },
    context_patterns = {
        "class",
        "function",
        "method",
        "block",
        "arguments",
        "typedef",
        "while",
        "return",
        "if_statement",
        "else_clause",
        "jsx_element",
        "jsx_self_closing_element",
        "try_statement",
        "catch_clause",
        "import_statement",
        "labeled_statement",
        "^for",
        "^object",
        "^table",
    },
})

-- PARA AS LINHAS DE INDENTAÇÃO

--vim.opt.listchars:append("space:⋅")
----vim.opt.listchars:append("eol:↴")
--vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

--vim.cmd([[
--  hi! MatchParen cterm=NONE,bold gui=NONE,bold guibg=NONE guifg=#FFFFFF
--  let g:indentLine_fileTypeExclude = ['dashboard']
--]])
