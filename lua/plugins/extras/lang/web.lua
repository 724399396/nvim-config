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
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "prettierd", "eslint_d" })
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			if type(opts.formatters_by_ft) == "table" then
				opts.formatters_by_ft["javascript"] = { "prettierd", "eslint_d" }
				opts.formatters_by_ft["typescript"] = { "prettierd", "eslint_d" }
				opts.formatters_by_ft["html"] = { "prettierd", "eslint_d" }
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {},
				cssls = {},
				lemminx = {},
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
