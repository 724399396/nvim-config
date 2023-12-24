M = {}

local function keymappings()
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }

	-- Key mappings
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
end

function M.on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", { buf = bufnr })

	-- Configure key mappings
	keymappings()

	-- tagfunc
	if client.server_capabilities.definitionProvider then
		vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
	end

	-- Configure for jdtls
	if client.name == "jdtls" then
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end
end

M.capabilities = vim.tbl_deep_extend("force", {
	textDocument = {
		completion = {
			completionItem = {
				snippetSupport = true,
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			},
		},
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
		colorProvider = {
			dynamicRegistration = true,
		},
	},
}, vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

return M
