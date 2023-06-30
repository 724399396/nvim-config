return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opt = {
    filesystem = {
      commands = {
        copy_file_name = function(state)
          local node = state.tree:get_node()
          vim.fn.setreg("*", node.name, "c")
        end,
      },
      window = {
        mappings = {
          ["Y"] = "copy_file_name",
        },
      },
    },
  },
}
