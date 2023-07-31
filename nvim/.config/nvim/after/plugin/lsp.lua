local lsp = require("lsp-zero")
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")


lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
	"clangd",
	"pyright",
	"lua_ls",
	"gopls",
	"bashls",
	"ltex",
	"cssls",
	"eslint",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(client, bufnr)
	if client.name == "tsserver" or client.name == "svelte" then
		local ns = vim.lsp.diagnostic.get_namespace(client.id)
		vim.diagnostic.disable(nil, ns)
	end

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, opts)
	vim.keymap.set("n", "gr", function()
		require("telescope.builtin").lsp_references()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

lsp.configure("eslint", {
	root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		on_attach(client, bufnr)
	end,
	capabilities = lsp_capabilities,
	settings = {
		format = {
			enable = false,
		},
	},
	handlers = {
		-- this error shows up occasionally when formatting
		-- formatting actually works, so this will supress it
		["window/showMessageRequest"] = function(_, result)
			if result.message:find("ENOENT") then
				return vim.NIL
			end

			return vim.lsp.handlers["window/showMessageRequest"](nil, result)
		end,
	},
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
