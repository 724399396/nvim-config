local M = {}

function M.setup()
	require("attempt").setup({
		list_buffers = true,
		ext_options = { "lua", "js", "json", "py", "cpp", "c", "sql", "" },
	})
	require("telescope").load_extension("attempt")
end

return M
