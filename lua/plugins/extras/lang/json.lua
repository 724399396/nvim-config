return {

	-- add json to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "json" })
			end
		end,
	},

	-- correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/SchemaStore.nvim",
			version = false, -- last release is way too old
		},
		opts = {
			-- make sure mason installs the server
			servers = {
				jsonls = {
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							format = {
								enable = false,
							},
							validate = { enable = true },
						},
					},
				},
			},
		},
	},

	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "fixjson" })
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			if type(opts.formatters_by_ft) == "table" then
				opts.formatters_by_ft["json"] = { "fixjson" }
			end
		end,
	},
}
