local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    fast_wrap = {},
})

require("nvim-autopairs.completion.cmp").setup({
    map_complete = false,
    insert = true,
})
