return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPre",
	build = ":TSUpdate",
	opts = {
		-- One of "all", "maintained" (parsers with maintainers), or a list of languages
		ensure_installed = {
			"bash",
			"dockerfile",
			"gitignore",
			"lua",
			"make",
			"ruby",
			"sql",
			"toml",
			"typescript",
			"yaml",
			"markdown_inline",
			"regex",
		},

		-- Install languages synchronously (only applied to `ensure_installed`)
		sync_install = false,
		-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
		auto_install = false,
		highlight = {
			-- conflitct with lsp highlight, will disable first file treesitter, so disable
			enable = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		indent = { enable = true, disable = { "python", "java", "rust", "lua", "vue" } },
		-- vim-matchup
		matchup = {
			enable = true,
		},
		-- nvim-treesitter-textsubjects
		textsubjects = {
			enable = true,
			prev_selection = ",", -- (Optional) keymap to select the previous selection
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
				["i;"] = "textsubjects-container-inner",
			},
		},
		autotag = {
			enable = true,
		},
	},
	config = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			---@type table<string, boolean>
			local added = {}
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end
		require("nvim-treesitter.configs").setup(opts)
	end,
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "RRethy/nvim-treesitter-textsubjects" },
		-- Auto tag
		{ "windwp/nvim-ts-autotag" },
	},
}
