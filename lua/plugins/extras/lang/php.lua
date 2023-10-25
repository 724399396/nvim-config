return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "php" })
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				psalm = {},
			},
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "php" })
		end,
	},
}
