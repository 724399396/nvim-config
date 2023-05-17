return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "java" })
			end
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local nls = require("null-ls")
			table.insert(opts.sources, nls.builtins.formatting.google_java_format)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jdtls = {},
			},
			setup = {
				["jdtls"] = function(_)
					return true
				end,
			},
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "javadbg", "javatest" })
		end,
	},

	{
		"mfussenegger/nvim-jdtls",
		dependencies = "nvim-lspconfig",
		ft = { "java" },
	},
}
