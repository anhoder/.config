-- neovide 不使用smooth
if vim.g.neovide then
  return {}
end

return {
  "karb94/neoscroll.nvim",
  config = function()
    require("neoscroll").setup({})
  end,
}
