return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "c", "cpp" })
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {},
			},
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "cppdbg" })
		end,
	},
}
