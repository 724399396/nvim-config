return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/SchemaStore.nvim",
			version = false, -- last release is way too old
		},
		opts = {
			servers = {
				yamlls = {
					settings = {
						yaml = {
							schmas = require("schemastore").yaml.schemas(),
						},
					},
				},
			},
		},
	},
}
