return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				filtered_items = {
					always_show = {
						".gitignore",
						".gitlab-ci.yml",
						".env",
						".env.development",
						".env.production",
					},
				},
				commands = {
					copy_file_name = function(state)
						local node = state.tree:get_node()
						vim.fn.setreg("*", node.name, "c")
					end,
				},
				window = {
					mappings = {
						["Y"] = "copy_file_name",
					},
				},
			},
		})
	end,
}
