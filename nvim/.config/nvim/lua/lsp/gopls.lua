local lspconfig = require("lspconfig")

local M = {}
M.setup = function(on_attach, capabilities)
    lspconfig.gopls.setup({
        on_attach = on_attach,
        cmd = {"gopls"},
        capabilities = capabilities,
    })
end

return M
