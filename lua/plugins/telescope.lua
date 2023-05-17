return {
  "nvim-telescope/telescope.nvim",
  keys = { "<leader>f" },
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
    { "nvim-telescope/telescope-smart-history.nvim", dependencies = "tami5/sqlite.lua" },
  },
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    -- Custom previewer
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")
    local preview_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]

          if mime_type == "text" then
            -- Check file size
            vim.loop.fs_stat(filepath, function(_, stat)
              if not stat then
                return
              end
              if stat.size > 500000 then
                return
              else
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
              end
            end)
          else
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY FILE" })
            end)
          end
        end,
      }):sync()
    end

    telescope.setup({
      defaults = {
        prompt_prefix = " " .. " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },
        buffer_previewer_maker = preview_maker,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
          },
        },
        history = {
          path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
          limit = 200,
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("smart_history")
    telescope.load_extension("notify")
  end,
}
