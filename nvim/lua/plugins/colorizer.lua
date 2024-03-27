return {
  "NvChad/nvim-colorizer.lua",
  ft = { "lua", "css", "html", "js", "ts" },
  opts = {
    filetypes = {
      "*",
      "!neo-tree",
    },
    user_default_options = {
      names = false,
      -- Available methods are false / true / "normal" / "lsp" / "both"
      tailwind = false,
    },
  },
}
