return {
  -- add gruvbox
  {
    "morhetz/gruvbox",
    -- "anhoder/vim-gruvbox",
    config = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_transparent_bg = 1
      vim.g.gruvbox_termcolors = 256
      vim.g.gruvbox_italicize_strings = 1
      vim.g.gruvbox_invert_selection = 0
      vim.g.gruvbox_invert_signs = 0
      vim.g.gruvbox_improved_warnings = 1
      vim.g.gruvbox_contrast_light = "hard"
      vim.g.gruvbox_contrast_dark = "hard"
    end,
  },
  {
    "xiantang/darcula-dark.nvim",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },

  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      -- set_dark_mode = function()
      --   if vim.g.colors_name ~= "gruvbox" then
      --     vim.cmd("colorscheme gruvbox")
      --   end
      --   vim.api.nvim_set_option_value("background", "dark", {})
      -- end,
      -- set_light_mode = function()
      --   if vim.g.colors_name ~= "rose-pine" then
      --     vim.cmd("colorscheme rose-pine")
      --   end
      --   vim.api.nvim_set_option_value("background", "light", {})
      -- end,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    -- version = "10.15.0",
    opts = {
      colorscheme = "gruvbox",
      -- colorscheme = "tokyonight",
      -- colorscheme = "habamax",
      -- colorscheme = "darcula-dark",
    },
  },
}
