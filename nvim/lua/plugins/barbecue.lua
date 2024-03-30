local icons = require("utils.icons")

return {
  "utilyre/barbecue.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    attach_navic = true,
    theme = "auto",
    include_buftypes = { "" },
    exclude_filetypes = { "gitcommit", "Trouble", "toggleterm", "netrw" },
    show_modified = false,
    kinds = icons.kinds,
    ---@diagnostic disable-next-line: unused-local
    custom_section = function(bufnr, winnr)
      return { { " ", "WinBar" } }
    end,
  },
}
