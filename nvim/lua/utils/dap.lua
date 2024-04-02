local M = {}

local dapui_opened = false

function M.dapui_close()
  dapui_opened = false
  require("dapui").close()
end

function M.dapui_open(opts)
  opts = opts or {}

  dapui_opened = true
  opts.reset = true
  require("dapui").open(opts)
  if not opts or not opts.layout then
    vim.cmd("Neotree close")
  end
end

function M.dapui_toggle()
  if dapui_opened then
    M.dapui_close()
  else
    M.dapui_open()
  end
end

return M
