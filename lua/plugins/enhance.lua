return {
	{
		"RaafatTurki/hex.nvim",
		config = true,
	},

	{
		"ggandor/leap.nvim",
		event = "BufReadPre",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	{ "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } },

	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
	},
	{
		"nvim-pack/nvim-spectre",
		cmd = { "Spectre" },
	},
	{ "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } },
	{
		"chentoast/marks.nvim",
		event = "BufReadPre",
		config = function()
			require("marks").setup({})
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("mini.ai").setup()
			require("mini.bracketed").setup()
			require("mini.comment").setup()
			require("mini.cursorword").setup()
			require("mini.move").setup()
			require("mini.pairs").setup()
			require("mini.splitjoin").setup()
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					replace = "gsr",
					update_n_lines = "gsn",
					suffix_last = "l",
					suffix_next = "n",
				},
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = true,
		cmd = { "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
    -- stylua: ignore
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
    },
	},
	{
		"voldikss/vim-translator",
		cmd = { "Translate" },
		config = function()
			vim.g.translator_target_lang = "zh"
			vim.g.translator_history_enable = true
		end,
	},
	{ "jiaoshijie/undotree", dependencies = "nvim-lua/plenary.nvim", config = true },
}
