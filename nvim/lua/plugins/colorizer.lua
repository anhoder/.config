return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    filetypes = {
      "*",
      "!noice",
      "!notify",
      "!neo-tree",
    },
    user_default_options = {
      names = false,
      -- Available methods are false / true / "normal" / "lsp" / "both"
      tailwind = false,
    },
  },
}
