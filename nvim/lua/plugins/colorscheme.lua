return {
  -- add gruvbox
  {
    "morhetz/gruvbox",
    config = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_transparent_bg = 1
      vim.g.gruvbox_termcolors = 256
      vim.g.gruvbox_italicize_strings = 1
      vim.g.gruvbox_invert_selection = 0
      vim.g.gruvbox_invert_signs = 0
      vim.g.gruvbox_improved_warnings = 1
      if vim.g.goneovim then
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_contrast_light = "hard"
      end
    end,
  },
  {
    "xiantang/darcula-dark.nvim",
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      -- transparent = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    -- version = "10.15.0",
    opts = {
      -- colorscheme = "gruvbox",
      -- colorscheme = "tokyonight",
      -- colorscheme = "habamax",
      colorscheme = "darcula-dark",
    },
  },
}
