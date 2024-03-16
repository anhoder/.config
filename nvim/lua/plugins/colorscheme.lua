vim.g.gruvbox_italic = 1
vim.g.gruvbox_transparent_bg = 1
vim.g.gruvbox_termcolors = 256
vim.g.gruvbox_italicize_strings = 1
vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_invert_signs = 0
vim.g.gruvbox_improved_warnings = 1

return {
  -- add gruvbox
  {
    "morhetz/gruvbox",
    -- "gruvbox-community/gruvbox",
    event = { "VeryLazy" },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    -- version = "10.12.1",
    opts = {
      colorscheme = "gruvbox",
      -- colorscheme = "habamax",
    },
  },
}
