local lspconfig = require("lspconfig")

local settings = {
	filetypes = {
		"javascript",
		"javascriptreact",
		"json",
		"typescript",
		"typescriptreact",
		"css",
		"less",
		"scss",
		"yaml",
	},
	init_options = {
		linters = {
			eslint = {
				command = "eslint_d",
				rootPatterns = { ".git", ".eslintrc" },
				debounce = 100,
				args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
				sourceName = "eslint_d",
				parseJson = {
					errorsRoot = "[0].messages",
					line = "line",
					column = "column",
					endline = "endline",
					endColumn = "endColumn",
					message = " [eslint] ${message} [${ruleId}]",
					security = "severity",
				},
				securities = {
					[2] = "error",
					[1] = "warning",
				},
			},
		},
		filetypes = {
			javascript = "eslint",
			javascriptreact = "eslint",
			typescript = "eslint",
			typescriptreact = "eslint",
		},
		formatters = {
			eslint_d = {
				command = "eslint_d",
				args = { "--stdin", "--stdin-filename", "%filename", "--fix-to-stdout" },
				rootPatterns = {},
			},
			prettier = {
				command = "prettier",
				args = { "--stdin-filepath", "%filename" },
			},
		},
		formatFiletypes = {
			css = "prettier",
			javascript = "eslint_d",
			javascriptreact = "eslint_d",
			json = "prettier",
			scss = "prettier",
			less = "prettier",
			typescript = "eslint_d",
			typescriptreact = "eslint_d",
			markdown = "prettier",
		},
	},
}

local M = {}
M.setup = function(on_attach, capabilities)
	lspconfig.diagnosticls.setup({
		on_attach = on_attach,
		filetypes = settings.filetypes,
		init_options = settings.init_options,
		capabilities = capabilities,
	})
end

return M
