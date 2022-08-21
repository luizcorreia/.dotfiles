
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- local root = vim.fn.getenv("HOME") .. "/tools/lua-language-server/"
-- local binary = root .. "bin/lua-language-server"
local settings = {
    Lua = {
        runtime = { version = "LuaJIT", path = runtime_path },
        workspace = {
            checkThirdParty = false,
            library = {
                ["${3rd}/love2d/library"] = true,
            },
        },
        diagnostics = {
            enable = true,
            globals = {
                "global",
                "vim",
                "use",
                "describe",
                "it",
                "assert",
                "before_each",
                "after_each",
            },
        },
        completion = {
            showWord = "Disable",
            callSnippet = "Disable",
            keywordSnippet = "Disable",
        },
    },
}

local M = {}

M.setup = function(on_attach, capabilities)
    local luadev = require("lua-dev").setup({
        lspconfig = {
            on_attach = on_attach,
            settings = settings,
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = capabilities,
        },
    })
    require("lspconfig").sumneko_lua.setup(luadev)
end

return M

