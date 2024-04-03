local M = {}

function M.is_gui()
  return not vim.g.neovide and not vim.g.goneovim
end

return M
