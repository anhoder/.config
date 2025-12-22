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
      -- vim.g.gruvbox_contrast_light = "hard"
      -- vim.g.gruvbox_contrast_dark = "hard"
    end,
  },
  {
    "xiantang/darcula-dark.nvim",
  },
  {
    -- "sainnhe/everforest",
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
        ---Default is "medium".
        background = "hard",
        ---How much of the background should be transparent. 2 will have more UI
        ---components be transparent (e.g. status line background)
        transparent_background_level = 0,
        ---Whether italics should be used for keywords and more.
        italics = true,
        ---Disable italic fonts for comments. Comments are in italics by default, set
        ---this to `true` to make them _not_ italic!
        disable_italic_comments = false,
        ---By default, the colour of the sign column background is the same as the as normal text
        ---background, but you can use a grey background by setting this to `"grey"`.
        sign_column_background = "none",
        ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
        ---`"low"` (default).
        ui_contrast = "low",
        ---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
        ---
        ---When this option is used in conjunction with show_eob set to `false`, the
        ---end of the buffer will only be hidden inside the active window. Inside
        ---inactive windows, the end of buffer filler characters will be visible in
        ---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
        dim_inactive_windows = false,
        ---Some plugins support highlighting error/warning/info/hint texts, by
        ---default these texts are only underlined, but you can use this option to
        ---also highlight the background of them.
        diagnostic_text_highlight = false,
        ---Which colour the diagnostic text should be. Options are `"grey"` or `"coloured"` (default)
        diagnostic_virtual_text = "coloured",
        ---Some plugins support highlighting error/warning/info/hint lines, but this
        ---feature is disabled by default in this colour scheme.
        diagnostic_line_highlight = false,
        ---By default, this color scheme won't colour the foreground of |spell|, instead
        ---colored under curls will be used. If you also want to colour the foreground,
        ---set this option to `true`.
        spell_foreground = true,
        ---Whether to show the EndOfBuffer highlight.
        show_eob = true,
        ---Style used to make floating windows stand out from other windows. `"bright"`
        ---makes the background of these windows lighter than |hl-Normal|, whereas
        ---`"dim"` makes it darker.
        ---
        ---Floating windows include for instance diagnostic pop-ups, scrollable
        ---documentation windows from completion engines, overlay windows from
        ---installers, etc.
        ---
        ---NB: This is only significant for dark backgrounds as the light palettes
        ---have the same colour for both values in the switch.
        float_style = "dim",
        ---Inlay hints are special markers that are displayed inline with the code to
        ---provide you with additional information. You can use this option to customize
        ---the background color of inlay hints.
        ---
        ---Options are `"none"` or `"dimmed"`.
        inlay_hints_background = "none",
      })
    end,
  },

  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      -- fallback = "light",
      enabled = function()
        local uname = vim.uv.os_uname()
        return uname.sysname:find("Darwin") ~= nil
      end,
      set_dark_mode = function()
        if vim.g.colors_name ~= "gruvbox" then
          vim.cmd("colorscheme gruvbox")
        end
        vim.api.nvim_set_option_value("background", "dark", {})
        require("utils.extra_highlight").refresh_extra_highlight_for_dark()
      end,
      set_light_mode = function()
        if vim.g.colors_name ~= "everforest" then
          vim.cmd("colorscheme everforest")
        end
        vim.api.nvim_set_option_value("background", "light", {})
        require("utils.extra_highlight").refresh_extra_highlight_for_light()
      end,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    -- version = "10.15.0",
    opts = {
      colorscheme = "gruvbox",
      -- colorscheme = "everforest",
      -- colorscheme = "tokyonight",
      -- colorscheme = "habamax",
      -- colorscheme = "darcula-dark",
    },
  },
}
