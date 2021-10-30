local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    fast_wrap = {},
})

require("cmp").setup({
    map_complete = false,
    insert = true,
})
