return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    search = {
      command = "rg",
      args = {
        "--glob=!vendor/",
        "--glob=!node_modules/",
        "--glob=!runtime/",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
    },
  },
}
