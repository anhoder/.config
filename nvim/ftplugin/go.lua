local map = vim.keymap.set

map({ "n", "v" }, "<leader>co", function()
  vim.cmd("GoCodeLenAct")
end, { desc = "GoCodeLenAct" })
