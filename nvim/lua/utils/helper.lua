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

function M.get_folder_node(tree, node)
  if not tree then
    return nil
  end
  if not node then
    node = tree:get_node()
  end
  if node.type == "directory" then
    return node
  end
  return M.get_folder_node(tree, tree:get_node(node:get_parent_id()))
end

function M.remove_prefix(str, prefix)
  return (string.sub(str, 0, #prefix) == prefix) and string.sub(str, #prefix + 1) or str
end

--- copy str to system clipboard
--- @param str string
function M.copy_to_clipboard(str)
  vim.fn.setreg("+", str, "c")
end

--- get current position
--- @param opts ?{absolute: boolean, with_line: boolean}
--- @return string
function M.get_current_position(opts)
  opts = opts or {}
  local path = nil

  if opts.absolute ~= nil and opts.absolute == true then
    path = vim.fn.expand("%:p")
  else
    path = M.remove_prefix(vim.fn.expand("%"), vim.fn.getcwd())
  end
  if opts.with_line ~= nil and opts.with_line == true then
    local line = vim.api.nvim_win_get_cursor(0)[1]
    path = string.format("%s:%d", path, line)
  end

  return path
end

return M
