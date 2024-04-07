local M = {}

function M.is_gui()
  return vim.g.neovide or vim.g.goneovim
end

return M
