local lspconfig = require("lspconfig")

local u = require("utils")

local ts_utils_settings = {
	debug = false,
	disable_commands = false,
	enable_import_on_completion = true,
	import_on_completion_timeout = 5000,

	-- eslint
	eslint_enable_code_actions = true,
	eslint_bin = "eslint_d",
	eslint_args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
	eslint_enable_disable_comments = true,

	-- experimental settings!
	-- eslint diagnostics
	eslint_enable_diagnostics = true,
	eslint_diagnostics_debounce = 250,

	-- -- formatting
	-- enable_formatting = true,
	-- formatter = "prettier",
	-- formatter_args = { "--stdin-filepath", "$FILENAME" },
	-- format_on_save = true,
	-- no_save_after_format = false,

	-- parentheses completion
	complete_parens = false,
	signature_help_in_parens = true,

	-- update imports on file move
	update_imports_on_move = false,
	require_confirmation_on_move = false,
	watch_dir = "/src",
}

local M = {}
M.setup = function(on_attach, capabilities)
	local ts_utils = require("nvim-lsp-ts-utils")

	lspconfig.tsserver.setup({
		init_options = ts_utils.init_options,
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			on_attach(client, bufnr)

			ts_utils.setup(ts_utils_settings)
			ts_utils.setup_client(client)

			u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
			u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
			u.buf_map("n", "go", ":TSLspImportAll<CR>", nil, bufnr)
			u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
		end,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	})
end

return M
