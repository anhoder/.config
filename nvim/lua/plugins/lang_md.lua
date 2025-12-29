return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },

  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = {
      -- Disable automatic rendering for manual-only workflow
      events = {
        render_buffer = {}, -- Empty = no automatic rendering
        clear_buffer = { "BufLeave" },
      },
      renderer_options = {
        mermaid = {
          theme = "dark",
          scale = 2,
        },
      },
    },
    keys = {
      {
        "K", -- or any key you prefer
        function()
          require("diagram").show_diagram_hover()
        end,
        mode = "n",
        ft = { "markdown", "norg" }, -- Only in these filetypes
        desc = "Show diagram in new tab",
      },
    },
  },
}
