return {
	"folke/which-key.nvim",
	event = "VimEnter",
	dependencies = { "mrjones2014/legendary.nvim" },
	config = function()
		local whichkey = require("which-key")

		whichkey.setup({
			window = {
				border = "none", -- none, single, double, shadow
				position = "bottom", -- bottom, top
			},
		})

		require("legendary").setup({
			include_builtin = true,
			which_key = {
				auto_register = true,
			},
		})
		whichkey.register({
			["<C-p>"] = { "<cmd>lua require('legendary').find()<CR>", "Show Keymap" },
		})

		whichkey.register({
			name = "Goto",
			d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
			D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
			h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
			b = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
			r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Show References" },
			I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go To Implementation" },
		}, { prefix = "g" })

		local keymap = {
			["w"] = { "<cmd>update!<CR>", "Save" },
			["T"] = { "<Cmd>Translate<CR>", "Translate" },
			["e"] = { "<cmd>Neotree reveal toggle<cr>", "Explorer" },
			["q"] = { "<cmd>q<cr>", "Quit" },
			a = {
				name = "Attempt",
				n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
				i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
				r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
				d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
				c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
			},
			b = {
				name = "Buffer",
				d = { "<Cmd>BDelete this<Cr>", "Delete Buffer" },
				D = { "<Cmd>BDelete! this<Cr>", "Force Delete Buffer" },
				o = { "<Cmd>BWipeout other<Cr>", "Delete Other Buffers" },
			},
			c = {
				name = "Code",
			},
			f = {
				name = "Find",
				f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
				b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
				h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
				m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
				o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
				w = { "<cmd>lua require('telescope.builtin').grep_string()<cr>", "Live Grep" },
				g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
				c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
				q = { "<cmd>lua require('telescope.builtin').quickfixhistory()<cr>", "Quickfix History" },
				n = { "<cmd>lua require'telescope'.extensions.notify.notify()<cr>", "Notify History" },
				t = { "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Todo/Fix/Fixme" },
				s = {
					"<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>",
					"Workspace Symbol",
				},
			},
			t = {
				name = "Terminal",
				p = { "<cmd>lua require('config.term').project_info_toggle()<CR>", "Project Info" },
				s = { "<cmd>lua require('config.term').system_info_toggle()<CR>", "System Info" },
				f = { "<cmd>ToggleTerm direction=float<CR>", "Toggle Terminal Horizontal" },
				h = { "<cmd>ToggleTerm direction=horizontal<CR>", "Toggle Terminal Horizontal" },
				v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Toggle Terminal Vertical" },
			},
			r = {
				name = "Refactor",
				i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
				f = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
				v = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
				p = { [[ <Esc><Cmd>lua require('refactoring').debug.printf({below = false})<CR>]], "Debug Print" },
				c = { [[ <Esc><Cmd>lua require('refactoring').debug.cleanup({below = false})<CR>]], "Debug Cleanup" },
				n = { [[ <Esc><Cmd>lua require("ts-node-action").node_action()<CR>]], "Trigger Node Action" },
			},
			z = {
				name = "System",
				l = { "<cmd>Lazy<cr>", "Lazy" },
				m = { "<cmd>Mason<cr>", "Mason" },
				e = { "!!$SHELL<CR>", "Execute line" },
				b = { "<cmd>lua require 'hex'.toggle()<cr>", "Hex" },
			},
			g = {
				name = "Git",
				b = { "<cmd>GitBlameToggle<CR>", "Blame" },
				s = { "<cmd>GitBlameCopySHA<CR>", "Copy SHA" },
				g = { "<cmd>lua require('config.term').git_client_toggle()<CR>", "Git TUI" },
			},
			i = {
				name = "Intelligence",
				p = { "<cmd>ChatGPT<CR>", "ChatGPT" },
				a = { "<cmd>ChatGPTActAs<CR>", "ChatGPT Act As" },
				e = { "<cmd>ChatGPTEditWithInstructions<CR>", "ChatGPT Edit" },
			},
			s = {
				name = "Others",
				r = { "<cmd>Spectre<cr>", "Replace in files (Spectre)" },
				n = {
					name = "Noice",
					l = { "<cmd>Noice last<CR>", "Noice Last Message" },
					h = { "<cmd>Noice history<CR>", "Noice History" },
					d = { "<cmd>Noice dismiss<CR>", "Dismiss All" },
				},
				s = {
					name = "Session",
					s = { "<cmd>lua require('persistence').load()<cr>", "Restore Session" },
					l = { "<cmd>lua require('persistence').load({last = true})<cr>", "Restore Last Session" },
					n = { "<cmd>lua require('persistence').stop()<cr>", "Dont' Save Current Session" },
				},
			},
			u = {
				name = "UI",
				n = {
					"<cmd>lua require('notify').dismiss({ silent = true, pending = true })<cr>",
					"Dismiss all Notifications",
				},
			},
			x = {
				name = "Trouble",
				x = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
				X = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
			},
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
				r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
				f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
				i = { "<cmd>LspInfo<CR>", "Lsp Info" },
				s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
				L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
				l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
				o = { "<cmd>Lspsaga outline<CR>", "Toggle Outline" },
				F = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format Document" },
			},
		}

		whichkey.register(keymap, {
			mode = "n", -- Normal mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
		})
		whichkey.register({
			r = {
				name = "Refactor",
				e = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
				f = {
					[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function to File')<CR>]],
					"Extract Function to File",
				},
				v = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
				i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
				r = { [[ <Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
				V = { [[ <Esc><Cmd>lua require('refactoring').debug.print_var({})<CR>]], "Debug Print Var" },
			},
			l = {
				name = "LSP",
				a = { "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
			},
		}, {
			mode = "v", -- Visual mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = false, -- use `nowait` when creating keymaps
		})

		local code_runner_group = vim.api.nvim_create_augroup("CodeRunner", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				vim.schedule(CodeRunner)
			end,
			group = code_runner_group,
		})

		function CodeRunner()
			local bufnr = vim.api.nvim_get_current_buf()
			local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
			local fname = vim.fn.expand("%:p:t")
			local keymap_c = {} -- normal key map
			local keymap_c_v = {} -- visual key map

			if ft == "python" then
				keymap_c = {
					name = "Code",
					r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
					m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
				}
			elseif ft == "lua" then
				keymap_c = {
					name = "Code",
					r = { "<cmd>luafile %<cr>", "Run" },
				}
			elseif ft == "rust" then
				keymap_c = {
					name = "Code",
					r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
					D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
					h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
					R = { "<cmd>RustRunnables<cr>", "Runnables" },
					m = { "<cmd>lua require'rust-tools'.expand_macro.expand_macro()<cr>", "Expand Macro" },
				}
			elseif ft == "go" then
				keymap_c = {
					name = "Code",
					r = { "<cmd>GoRun<cr>", "Run" },
				}
			elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
				keymap_c = {
					name = "Code",
					o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
					r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
					i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
					F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
					u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
				}
			elseif ft == "java" then
				keymap_c = {
					name = "Code",
					o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
					v = { "<cmd>lua require('jdtls').extract_variable_all()<cr>", "Extract Variable" },
					c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
					m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
					t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
					n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
					b = { "<cmd>lua require('jdtls').javap()<cr>", "Show Current File Bytecode" },
					j = { "<cmd>lua require('jdtls').jshell()<cr>", "JShell" },
				}
				keymap_c_v = {
					name = "Code",
					v = { "<cmd>lua require('jdtls').extract_variable_all(true)<cr>", "Extract Variable" },
					c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
					m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
				}
			elseif ft == "dart" then
				keymap_c = {
					name = "Code",
					r = { "<cmd>FlutterReload<cr>", "Flutter Hot Reload" },
					R = { "<cmd>FlutterRestart<cr>", "Flutter Hot Restart" },
				}
			elseif ft == "markdown" then
				keymap_c = {
					name = "Code",
					p = { "<cmd>MarkdownPreview<cr>", "Preview Markdown" },
				}
			end

			if fname == "package.json" then
				keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
				keymap_c.i = { "<cmd>lua require('package-info').install()<cr>", "Install Package" }
				keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
			end

			if fname == "Cargo.toml" then
				keymap_c.u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" }
				keymap_c.v = { "<cmd>lua require('crates').show_versions_popup()<cr>", "Show Versions" }
				keymap_c.f = { "<cmd>lua require('crates').show_features_popup()<cr>", "Show Features" }
			end

			-- overseer.nvim
			keymap_c.s = { "<cmd>OverseerRun<cr>", "Overseer Run" }
			keymap_c.S = { "<cmd>OverseerToggle!<cr>", "Overseer Toggle" }
			keymap_c.a = { "<cmd>OverseerQuickAction<cr>", "Overseer Quick Action" }
			keymap_c.A = { "<cmd>OverseerTaskAction<cr>", "Overseer Task Action" }

			if next(keymap_c) ~= nil then
				local k = { c = keymap_c }
				local o = {
					mode = "n",
					silent = true,
					noremap = true,
					buffer = bufnr,
					prefix = "<leader>",
					nowait = true,
				}
				whichkey.register(k, o)
			end

			if next(keymap_c_v) ~= nil then
				local k = { c = keymap_c_v }
				local o = {
					mode = "v",
					silent = true,
					noremap = true,
					buffer = bufnr,
					prefix = "<leader>",
					nowait = true,
				}
				whichkey.register(k, o)
			end
		end
	end,
}
