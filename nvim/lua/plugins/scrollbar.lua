return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    excluded_filetypes = {
      "prompt",
      "TelescopePrompt",
      "noice",
      "neo-tree",
      "dashboard",
      "alpha",
      "lazy",
      "mason",
      "DressingInput",
      "neo-tree-popup",
      "",
    },
    handle = {
      color = "#484848", -- Color of the handle
      blend = 10, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
    },
    handlers = {
      gitsigns = true,
    },
  },
}
