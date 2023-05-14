local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- Git client
local git_tui = "lazygit"

-- Tokei
local tokei = "tokei"

-- Bottom
local bottom = "btm"

local git_client = Terminal:new({
  cmd = git_tui,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
})

local project_info = Terminal:new({
  cmd = tokei,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  close_on_exit = false,
})

local system_info = Terminal:new({
  cmd = bottom,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  close_on_exit = true,
})

function M.git_client_toggle()
  git_client:toggle()
end

function M.project_info_toggle()
  project_info:toggle()
end

function M.system_info_toggle()
  system_info:toggle()
end

return M
