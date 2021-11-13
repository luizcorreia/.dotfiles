local lspconfig = require("lspconfig")

local M = {}
M.setup = function(on_attach, capabilities)
	lspconfig.eslint.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

return M
