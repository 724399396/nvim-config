return {
  {
    "stevearc/dressing.nvim",
    event = "BufReadPre",
    config = true,
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

  { "google/vim-searchindex", event = "BufReadPre" },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("indent_blankline").setup({
        show_current_context = true,
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = true,
    enabled = false,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPre",
    config = true,
    enabled = false,
  },
}
