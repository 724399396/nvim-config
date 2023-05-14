local M = {}

local nls = require("null-ls")
local nls_utils = require("null-ls.utils")
local b = nls.builtins

local sources = {
  -- formatting
  b.formatting.prettierd,
  b.formatting.shfmt,
  b.formatting.fixjson,
  b.formatting.black.with({ extra_args = { "--fast" } }),
  b.formatting.stylua,
  b.formatting.google_java_format,
  b.formatting.xmllint,
  b.formatting.sqlformat,

  -- diagnostics
  b.diagnostics.eslint_d,
  b.diagnostics.flake8.with({ extra_args = { "--max-line-length=100" } }),

  -- code actions
  b.code_actions.eslint_d,
  b.code_actions.refactoring,
}

function M.setup(opts)
  nls.setup({
    -- debug = true,
    debounce = 150,
    save_after_format = true,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern(".git"),
  })
end

return M
