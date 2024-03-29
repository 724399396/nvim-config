return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "c_sharp" })
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				omnisharp = {},
			},
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "coreclr" })
		end,
	},
}
