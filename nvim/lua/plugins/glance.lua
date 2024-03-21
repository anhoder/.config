if true then
  return {}
end

return {
  "dnlhc/glance.nvim",
  opts = {
    border = {
      enable = true,
    },
    list = {
      position = "left",
      width = 0.3,
    },
    hooks = {
      before_open = function(results, open, jump, _)
        if #results == 1 then
          jump(results[1])
        else
          open(results)
          vim.keymap.set({ "n", "i", "v" }, "<2-LeftMouse>", "<CR>", { remap = true })
        end
      end,
      before_close = function()
        vim.keymap.del({ "n", "i", "v" }, "<2-LeftMouse>")
      end,
    },
  },
}
