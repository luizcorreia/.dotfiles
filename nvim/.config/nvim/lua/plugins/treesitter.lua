require("nvim-treesitter.configs").setup({
    indent = { enable = true },
    highlight = { enable = true },
    ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "lua",
        "json",
        "jsonc",
        "yaml",
    },
    -- plugins
    autopairs = { enable = true },
    context_commentstring = {
        enable = true,
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
        },
    },
    autotag = {
        enable = true,
    },
})
