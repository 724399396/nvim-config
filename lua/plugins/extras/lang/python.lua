return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "python" })
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pylsp = {},
			},
		},
	},

	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "isort", "black" })
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			if type(opts.formatters_by_ft) == "table" then
				opts.formatters_by_ft["python"] = { "isort", "black" }
			end
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "python" })
		end,
	},
}
