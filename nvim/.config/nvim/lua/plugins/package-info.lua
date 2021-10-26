local u = require("utils")

local api = vim.api

require("package-info").setup({ icons = { enable = false } })

global.setup_package_json = function()
    local bufnr = api.nvim_get_current_buf()
    local map = function(key, cmd)
        u.buf_map("n", "<Leader>" .. key, "<cmd> lua require('package-info')." .. cmd .. "()<CR>", nil, bufnr)
    end

    map("ns", "show")
    map("nc", "hide")
    map("nu", "update")
    map("nd", "delete")
    map("ni", "install")
    map("nr", "reinstall")
    map("np", "change_version")
end

vim.cmd("autocmd BufReadPost package.json lua global.setup_package_json()")
