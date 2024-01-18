local map = vim.keymap.set

map({ "n", "v" }, "<leader>co", function()
  vim.cmd("RustHoverActions")
end, { desc = "RustHoverActions" })
