local M = {}

local function configure()
  local dap_breakpoint = {
    error = {
      text = "🟥",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "⭐️",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
  local dap, dapui = require("dap"), require("dapui")
  dapui.setup({}) -- use default
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end
end

local function configure_debuggers()
  require("config.dap.lua").setup()
  require("config.dap.go").setup()
  require("config.dap.csharp").setup()
end

function M.setup()
  require("mason-nvim-dap").setup({
    ensure_installed = { "javadbg", "javatest", "codelldb", "chrome", "python", "cppdbg" },
    automatic_setup = true,
  })
  configure()                          -- Configuration
  configure_exts()                     -- Extensions
  configure_debuggers()                -- Debugger
  require("config.dap.keymaps").setup() -- Keymaps
end

configure_debuggers()

return M
