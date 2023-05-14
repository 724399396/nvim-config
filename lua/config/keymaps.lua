local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Remap leader and local leader to <Space>

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- window split
keymap("n", "|", ":set nosplitright<CR>:vsplit<CR>", opts)
keymap("n", "\\", ":set splitright<CR>:split<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", opts)
keymap("n", "<Up>", ":resize -1<CR>", opts)
keymap("n", "<Down>", ":resize +1<CR>", opts)

-- Navigate tabs
keymap("n", "tu", ":tabe<CR>", opts)
keymap("n", "[t", ":tabprevious<CR>", opts)
keymap("n", "]t", ":tabnext<CR>", opts)

-- Navigate argument list
keymap("n", "[a", ":previous<CR>", opts)
keymap("n", "]a", ":next<CR>", opts)

keymap("n", "[q", ":cprevious<CR>", opts)
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[Q", ":cfirst<CR>", opts)
keymap("n", "]Q", ":clast<CR>", opts)

-- Center search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', opts)

-- Cancel search highlighting with ESC
keymap("n", "<C-[>", ":nohlsearch<Bar>:echo<CR>", opts)

-- Browser search
keymap("n", "gx", "<Plug>(openbrowser-smart-search)", opts)
keymap("x", "gx", "<Plug>(openbrowser-smart-search)", opts)

-- Terminal
keymap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
keymap("n", "<C-\\>", "<cmd>ToggleTerm direction=float<CR>", opts)
