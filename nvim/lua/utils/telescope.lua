local icons = require("utils.icons")

---@class beastvim.utils.telescope
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

---Get the border characters for the given border style
--- @param border_style? BorderStyle
--- @param order? BorderOrder
--- @param opts? BorderIcons
function M.borderchars(border_style, order, opts)
  order = order or "t-r-b-l-tl-tr-br-bl"
  local border_icons = icons.borders
  --- @type BorderIcons
  local border = vim.tbl_deep_extend("force", border_icons[border_style or "empty"], opts or {})

  local borderchars = {}

  local extract_directions = (function()
    ---@type number | nil
    local index = 1
    return function()
      if index == nil then
        return nil
      end
      -- Find the next occurence of `char`
      local nextIndex = string.find(order, "-", index)
      -- Extract the first direction
      local direction = string.sub(order, index, nextIndex and nextIndex - 1)
      -- Update the index to nextIndex
      index = nextIndex and nextIndex + 1 or nil
      return direction
    end
  end)()

  local mappings = {
    t = "top",
    r = "right",
    b = "bottom",
    l = "left",
    tl = "top_left",
    tr = "top_right",
    br = "bottom_right",
    bl = "bottom_left",
  }
  local direction = extract_directions()
  while direction do
    if mappings[direction] == nil then
      vim.notify(string.format("Invalid direction '%s'", direction), "ERROR")
    end
    borderchars[#borderchars + 1] = border[mappings[direction]]
    direction = extract_directions()
  end

  if #borderchars ~= 8 then
    vim.notify(string.format("Invalid order '%s'", order), "ERROR")
  end

  return borderchars
end

return M
