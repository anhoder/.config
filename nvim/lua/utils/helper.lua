local M = {}

function M.tbl_remove(tbl, value)
  local index = nil

  for i, v in ipairs(tbl) do
    if v == value then
      index = i
      break
    end
  end

  if index then
    table.remove(tbl, index)
  end
end

return M
