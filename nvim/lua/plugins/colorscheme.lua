vim.g.gruvbox_italic = 1
vim.g.gruvbox_transparent_bg = 1
vim.g.gruvbox_termcolors = 256
if vim.g.neovide then
  vim.g.gruvbox_contrast_dark = "soft"
end
vim.g.gruvbox_italicize_strings = 1
vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_invert_signs = 0
vim.g.gruvbox_improved_warnings = 1

return {
  -- add gruvbox
  { "morhetz/gruvbox" },
  { "rebelot/kanagawa.nvim" },
  {
    "olimorris/onedarkpro.nvim",
    opts = {
      options = {
        -- transparency = true,
        cursorline = true,
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "onedark",
      colorscheme = "gruvbox",
      -- colorscheme = "kanagawa",
    },
  },
}
