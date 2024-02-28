local icons = require("utils.icons")

return {
  "utilyre/barbecue.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    attach_navic = false,
    theme = "auto",
    include_buftypes = { "" },
    exclude_filetypes = { "gitcommit", "Trouble", "toggleterm" },
    show_modified = false,
    kinds = icons.kinds,
  },
}
