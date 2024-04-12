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
    show_dirname = false,
    context_follow_icon_color = true,
    kinds = icons.kinds,
    --- @diagnostic disable-next-line: unused-local
    custom_section = function(bufnr, winnr)
      return { { " ", "WinBar" } }
    end,
  },
}
