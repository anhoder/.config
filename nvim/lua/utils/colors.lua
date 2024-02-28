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

return M
