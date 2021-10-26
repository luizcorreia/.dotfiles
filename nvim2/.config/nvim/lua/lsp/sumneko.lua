local lspconfig = require("lspconfig")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local root = vim.fn.getenv("HOME") .. "/tools/lua-language-server/"
local binary = root .. "bin/Linux/lua-language-server"
local settings = {
  Lua = {
    runtime = { version = "LuaJIT", path = runtime_path },
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true),
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
  },
}

local M = {}
M.setup = function(on_attach, capabilities)
  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    cmd = { binary, "-E", root .. "main.lua" },
    settings = settings,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities,
  })
end

return M
