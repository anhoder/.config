local colors = {
  "#C0CAF5",
  "#f7768e",
  "#7aa2f7",
  "#e0af68",
  "#9ece6a",
  "#0DB9D7",
  "#9d7cd8",
  "#737aa2",
  "#787c99",
}

local M = {}

function M.random_color()
  math.randomseed(os.time())
  return colors[math.random(1, #colors)]
end

---Get normalised colour
---@param name string like 'pink' or '#fa8072'
---@return string[]
local get_color = function(name)
  local color = vim.api.nvim_get_color_by_name(name)
  if color == -1 then
    color = vim.opt.background:get() == "dark" and 000 or 255255255
  end

  ---Convert colour to hex
  ---@param value integer
  ---@param offset integer
  ---@return integer
  local byte = function(value, offset)
    return bit.band(bit.rshift(value, offset), 0xFF)
  end

  return { byte(color, 16), byte(color, 8), byte(color, 0) }
end

---Get visually transparent colour
---@param fg string like 'pink' or '#fa8072'
---@param bg string like 'pink' or '#fa8072'
---@param alpha integer number between 0 and 1
---@return string
function M.blend(fg, bg, alpha)
  local bg_color = get_color(bg)
  local fg_color = get_color(fg)

  ---@param i integer
  ---@return integer
  local channel = function(i)
    local ret = (alpha * fg_color[i] + ((1 - alpha) * bg_color[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", channel(1), channel(2), channel(3))
end

return M
