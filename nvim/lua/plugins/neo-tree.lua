return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {
    --   "3rd/image.nvim",
    --   opts = {
    --     backend = "kitty",
    --   },
    -- },
  },
  opts = {
    enable_normal_mode_for_inputs = true,
    filesystem = {
      filtered_items = {
        -- visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          ".idea",
          -- ".vscode",
          ".fleet",
          ".DS_Store",
        },
        never_show = {},
      },
      follow_current_file = {
        enabled = false,
        leave_dirs_open = false,
        group_empty_dirs = true,
      },
    },
    window = {
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = true } },
      },
    },
  },
}
