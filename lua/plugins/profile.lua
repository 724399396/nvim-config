return {
  "t-troebst/perfanno.nvim",
  keys = "<leader>p",
  config = function()
    local perfanno = require("perfanno")

    perfanno.setup({})

    local keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    keymap("n", "<LEADER>plf", ":PerfLoadFlat<CR>", opts)
    keymap("n", "<LEADER>plg", ":PerfLoadCallGraph<CR>", opts)
    keymap("n", "<LEADER>plo", ":PerfLoadFlameGraph<CR>", opts)

    keymap("n", "<LEADER>pe", ":PerfPickEvent<CR>", opts)

    keymap("n", "<LEADER>pa", ":PerfAnnotate<CR>", opts)
    keymap("n", "<LEADER>pf", ":PerfAnnotateFunction<CR>", opts)
    keymap("v", "<LEADER>pa", ":PerfAnnotateSelection<CR>", opts)

    keymap("n", "<LEADER>pt", ":PerfToggleAnnotations<CR>", opts)

    keymap("n", "<LEADER>ph", ":PerfHottestLines<CR>", opts)
    keymap("n", "<LEADER>ps", ":PerfHottestSymbols<CR>", opts)
    keymap("n", "<LEADER>pc", ":PerfHottestCallersFunction<CR>", opts)
    keymap("v", "<LEADER>pc", ":PerfHottestCallersSelection<CR>", opts)
  end,
}
