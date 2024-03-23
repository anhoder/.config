return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "mrbjarksen/neo-tree-diagnostics.nvim",
    {
      "3rd/image.nvim",
      opts = {
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = false,
            download_remote_images = false,
            only_render_image_at_cursor = true,
          },
          neorg = {
            enabled = false,
            download_remote_images = false,
            only_render_image_at_cursor = true,
          },
        },
      },
    },
  },
  opts = require("utils.neo-tree"),
}
