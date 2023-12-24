return {
	"m-demare/attempt.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	keys = { "<leader>a" },
	config = function()
		require("attempt").setup({
			list_buffers = true,
			ext_options = { "lua", "js", "json", "py", "cpp", "c", "sql", "" },
		})
	end,
}
