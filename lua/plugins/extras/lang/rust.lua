return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "rust" })
			end
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "codelldb" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				rust_analyzer = {},
			},
		},
		setup = {
			["rust_analyzer"] = function(_)
				return true
			end,
		},
	},

	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- Package installation folder
			local install_root_dir = vim.fn.stdpath("data") .. "/mason"

			-- DAP settings - https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
			local extension_path = install_root_dir .. "/packages/codelldb/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

			require("rust-tools").setup({
				server = {
					settings = {
						["rust-analyzer"] = {
							inlayHints = { locationLinks = false },
							cargo = { allFeatures = true },
							checkOnSave = {
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
						},
					},
					on_attach = require("config.lsp").on_attach,
					capabilities = require("config.lsp").capabilities,
				},
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			})
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
}
