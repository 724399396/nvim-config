return {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",

  -- Performance
  {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  },

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- Startup screen
  {
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  },

  -- Git
  { "f-person/git-blame.nvim",    cmd = { "GitBlameToggle" } },

  -- WhichKey
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    dependencies = { "mrjones2014/legendary.nvim" },
    config = function()
      require("config.whichkey").setup()
    end,
  },

  -- IndentLine
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  },

  -- Move
  {
    "ggandor/leap.nvim",
    event = "BufReadPre",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "ggandor/flit.nvim",
    event = "BufReadPre",
    dependencies = { "ggandor/leap.nvim" },
    config = function()
      require("flit").setup()
    end,
  },

  -- Motions
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup()
    end,
  },

  -- Buffer
  { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } },

  {
    "chentoast/marks.nvim",
    event = "BufReadPre",
    config = function()
      require("marks").setup({})
    end,
  },

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    dependencies = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre",
    config = function()
      require("config.lualine").setup()
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter").setup()
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "RRethy/nvim-treesitter-textsubjects" },
      -- Auto tag
      { "windwp/nvim-ts-autotag" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope").setup()
    end,
    cmd = { "Telescope" },
    keys = { "<leader>f", "<leader>p", "<leader>z" },
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
      { "nvim-telescope/telescope-smart-history.nvim", dependencies = "tami5/sqlite.lua" },
    },
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },

  -- interface
  {
    "stevearc/dressing.nvim",
    event = "BufReadPre",
    config = function()
      require("dressing").setup()
    end,
  },

  {
    "rcarriga/nvim-notify",
    event = "BufReadPre",
    config = function()
      local notify = require("notify")
      notify.setup({
        background_colour = "#000000",
        timeout = 2000,
      })
      vim.notify = notify
    end,
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,    -- use a classic bottom cmdline for search
          command_palette = true,  -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,      -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,  -- add a border to hover docs and signature help
        },
      })
    end,
  },

  { "google/vim-searchindex",  event = "BufReadPre" },

  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
  },

  -- session
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup()
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("config.cmp").setup()
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason" },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      require("config.lsp").setup()
    end,
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "folke/neodev.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup({})
        end,
      },
      { "b0o/schemastore.nvim" },
      { "jose-elias-alvarez/typescript.nvim" },
      { "lvimuser/lsp-inlayhints.nvim" },
    },
  },

  -- trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
  },

  -- lspsaga.nvim
  {
    "glepnir/lspsaga.nvim",
    cmd = { "Lspsaga" },
    config = function()
      require("lspsaga").setup({})
    end,
  },

  -- Rust
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
    ft = { "rust" },
    config = function()
      -- Package installation folder
      local install_root_dir = vim.fn.stdpath("data") .. "/mason"

      -- DAP settings - https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
      local extension_path = install_root_dir .. "/packages/codelldb/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

      require("rust-tools").setup({
        server = {
          settings = {
            ["rust-analyzer"] = {
              inlayHints = { locationLinks = false },
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
          on_attach = require("config.lsp").on_attach,
          capabilities = require("config.lsp").capabilities,
        },
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      })
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
  },

  -- Java
  { "mfussenegger/nvim-jdtls", ft = { "java" } },

  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart", "yaml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.flutter").setup()
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    keys = { "<leader>d" },
    dependencies = {
      { "rcarriga/nvim-dap-ui",             version = "v2.6.0" },
      { "jay-babu/mason-nvim-dap.nvim" },
      { "mfussenegger/nvim-dap-python" },
      { "leoluz/nvim-dap-go" },
      { "jbyuki/one-small-step-for-vimkind" },
    },
    config = function()
      require("config.dap").setup()
    end,
  },

  -- Web
  {
    "vuki656/package-info.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    ft = { "json" },
    config = function()
      require("package-info").setup({})
    end,
  },

  -- Refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = { "<leader>r" },
    config = function()
      require("refactoring").setup({})
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({})
    end,
  },

  -- Plugin
  {
    "tpope/vim-scriptease",
    cmd = {
      "Messages", --view messages in quickfix list
      "Verbose", -- view verbose output in preview window.
      "Time",  -- measure how long it takes to run some stuff.
    },
    event = "BufReadPre",
  },

  -- Todo
  {
    "folke/todo-comments.nvim",
    config = true,
    cmd = { "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    -- stylua: ignore
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
    },
  },

  -- Translation
  {
    "voldikss/vim-translator",
    cmd = { "Translate" },
    config = function()
      vim.g.translator_target_lang = "zh"
      vim.g.translator_history_enable = true
    end,
  },

  -- Task runner
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerToggle", "OverseerRun", "OverseerBuild" },
    config = function()
      require("overseer").setup()
    end,
  },

  -- Testing
  {
    "m-demare/attempt.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = { "<leader>a" },
    config = function()
      require("config.attempt").setup()
    end,
  },

  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        keymaps = {
          submit = "<C-e>",
        },
      })
    end,
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions" },
    keys = { "<leader>i" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "RaafatTurki/hex.nvim",
    config = function()
      require("hex").setup()
    end,
  },

  {
    "echasnovski/mini.nvim",
    version = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("mini.ai").setup()
      require("mini.bracketed").setup()
      require("mini.comment").setup({
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring()
          end,
        },
      })
      require("mini.cursorword").setup()
      require("mini.move").setup()
      require("mini.pairs").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup({
        mappings = {
          add = "gsa",
          delete = "gsd",
          find = "gsf",
          find_left = "gsF",
          highlight = "gsh",
          replace = "gsr",
          update_n_lines = "gsn",
          suffix_last = "l",
          suffix_next = "n",
        },
      })
    end,
  },
}
