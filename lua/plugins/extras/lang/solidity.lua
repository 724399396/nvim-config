return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "solidity" })
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				solidity_ls_nomicfoundation = {},
			},
		},
	},
}
