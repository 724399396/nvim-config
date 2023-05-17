return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "http", "html", "javascript", "css", "scss" })
			end
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.prettierd)
			table.insert(opts.sources, nls.builtins.formatting.xmllint)
			table.insert(opts.sources, nls.builtins.diagnostics.eslint_d)
			table.insert(opts.sources, nls.builtins.code_actions.eslint_d)
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"prettierd",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {},
				cssls = {},
			},
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "chrome" })
		end,
	},

	{
		"vuki656/package-info.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		ft = { "json" },
		config = true,
	},
}
