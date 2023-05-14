local M = {}

local whichkey = require("which-key")

-- local function keymap(lhs, rhs, desc)
--   vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
-- end

function M.setup()
  local keymap = {
    d = {
      name = "DAP",
      b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      B = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      g = { "<cmd>lua require'dap'.goto_()<cr>", "Go to line (no execute)" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      j = { "<cmd>lua require'dap'.down()<cr>", "Down" },
      k = { "<cmd>lua require'dap'.up()<cr>", "Up" },
      l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
      O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      s = { "<cmd>lua require'dap'.session()<cr>", "Session" },
      w = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      N = { "<cmd>lua require'osv'.launch({port = 54321})<cr>", "Neovim Debug mode" },
    },
  }
  local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }
  whichkey.register(keymap, opts)

  local keymap_v = {
    d = {
      name = "Debug",
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    },
  }
  opts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }
  whichkey.register(keymap_v, opts)
end

return M
