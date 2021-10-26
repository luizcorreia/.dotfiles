local u = require("utils")

local commands = {}

-- make global to make ex commands easier
_G.inspect = function(...)
    print(vim.inspect(...))
end

commands.edit_test_file = function(cmd)
    cmd = cmd or "edit"

    local done = function(file)
        vim.cmd(cmd:gsub("$FILE", file))
    end

    local root, ft = vim.pesc(vim.fn.expand("%:t:r")), vim.bo.filetype

    local patterns = {}
    if ft == "lua" then
        table.insert(patterns, "_spec")
    elseif ft == "typescript" or ft == "typescriptreact" then
        table.insert(patterns, "%.test")
        table.insert(patterns, "%.spec")
    end

    local final_patterns = {}
    for _, pattern in ipairs(patterns) do
        -- go from test file to non-test file
        if root:match(pattern) then
            pattern = root:gsub(vim.pesc(pattern), "")
        else
            pattern = root .. pattern
        end
        -- make sure extension matches
        pattern = pattern .. "%." .. vim.fn.expand("%:e") .. "$"
        table.insert(final_patterns, pattern)
    end

    -- check buffers first
    for _, b in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        for _, pattern in ipairs(final_patterns) do
            if b.name:match(pattern) then
                vim.cmd(cmd .. " #" .. b.bufnr)
                return
            end
        end
    end

    local scandir = function(path, depth, next)
        require("plenary.scandir").scan_dir_async(path, {
            depth = depth,
            search_pattern = final_patterns,
            on_exit = vim.schedule_wrap(function(found)
                if found[1] then
                    done(found[1])
                    return
                end

                assert(next, "test file not found")
                next()
            end),
        })
    end

    -- check same dir files first, then cwd
    scandir(vim.fn.expand("%:p:h"), 1, function()
        scandir(vim.fn.getcwd(), 5)
    end)
end

vim.cmd("command! -complete=command -nargs=* TestFile lua global.commands.edit_test_file(<f-args>)")
u.map("n", "<Leader>tv", ":TestFile vsplit<CR>")

global.commands = commands

-- misc
-- highlight on yank
vim.cmd('autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })')

-- always start terminals in insert mode
vim.cmd("autocmd TermOpen * startinsert")

-- save on <CR> in normal buffers
u.map("n", "<CR>", "(&buftype is# '' ? ':w<CR>' : '<CR>')", { expr = true })

-- delete current file and buffer
u.command("Remove", "call delete(expand('%')) | bdelete")

-- get help for word under cursor
u.command("Help", 'execute ":help" expand("<cword>")')

return commands
