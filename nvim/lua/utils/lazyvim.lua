local M = {}

function M.check_extra_enabled(extra)
  return vim.list_contains(LazyVim.config.json.data.extras, extra)
end

return M
