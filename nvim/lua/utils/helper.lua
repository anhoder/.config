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

return M
