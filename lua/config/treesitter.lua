local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "dart",
      "dockerfile",
      "gitignore",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "python",
      "ruby",
      "rust",
      "scss",
      "sql",
      "toml",
      "typescript",
      "vue",
      "yaml",
      "markdown",
      "markdown_inline",
      "http",
      "regex",
    },

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    highlight = {
      -- conflitct with lsp highlight, will disable first file treesitter, so disable
      enable = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = { enable = true, disable = { "python", "java", "rust", "lua", "vue" } },
    -- vim-matchup
    matchup = {
      enable = true,
    },
    -- nvim-treesitter-textsubjects
    textsubjects = {
      enable = true,
      prev_selection = ",", -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },
    -- context_commentstring
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    autotag = {
      enable = true,
    },
  })
end

return M
