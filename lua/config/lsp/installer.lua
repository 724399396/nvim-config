local util = require("lspconfig.util")
local M = {}

local function get_typescript_server_path(root_dir)
  local global_ts = "/home/weili/.nvm/versions/node/v19.0.0/lib/node_modules/typescript/lib"
  local found_ts = ""
  local function check_dir(path)
    found_ts = util.path.join(path, "node_modules", "typescript", "lib")
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

local servers = {
  gopls = {},
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = "true" },
      },
      init_options = {
        provideFormatter = false,
      },
    },
  },
  pyright = {
    analysis = {
      typeCheckingMode = "off",
    },
  },
  rust_analyzer = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  tailwindcss = {},
  yamlls = {
    schemastore = {
      enable = true,
    },
    settings = {
      yaml = {
        hover = true,
        completion = true,
        validate = true,
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  jdtls = {},
  dockerls = {},
  bashls = {},
  marksman = {},
  volar = {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    on_new_config = function(new_config, new_root_dir)
      new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
    end,
  },
  clangd = {},
  cssls = {},
}

function M.setup(options)
  require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
  })
  local lspconfig = require("lspconfig")
  local icons = require("config.icons")

  require("mason").setup({
    ui = {
      icons = {
        package_installed = icons.server_installed,
        package_pending = icons.server_pending,
        package_uninstalled = icons.server_uninstalled,
      },
    },
  })
  require("mason-tool-installer").setup({
    ensure_installed = {
      "stylua",
      "shfmt",
      "black",
    },
    auto_update = false,
    run_on_start = true,
  })

  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})
      lspconfig[server_name].setup(opts)
    end,
    ["jdtls"] = function(_)
    end,
    ["rust_analyzer"] = function(_)
    end,
  })
end

return M
