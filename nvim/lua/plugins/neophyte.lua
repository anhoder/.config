return {
  {
    "tim-harding/neophyte",
    tag = "0.3.0",
    event = "VeryLazy",
    opts = {
      fonts = {
        {
          name = "JetBrainsMono Nerd Font",
          features = {
            "+zero",
          },
        },
        -- Shorthand for no features or variations
        "PingFang TC",
        "Symbols Nerd Font",
      },
      font_size = {
        kind = "height", -- 'width' | 'height'
        size = 16,
      },
      -- Multipliers of the base animation speed.
      -- To disable animations, set these to large values like 1000.
      cursor_speed = 2,
      scroll_speed = 2,
      -- Increase or decrease the distance from the baseline for underlines.
      underline_offset = 1,
      -- For transparent window effects, use this to set the default background color.
      -- This is because most colorschemes in transparent mode unset the background,
      -- which normally defaults to the terminal background, but we don't have that here.
      -- You must also pass --transparent as a command-line argument to see the effect.
      -- Channel values are in the range 0-255.
      bg_override = {
        r = 48,
        g = 52,
        b = 70,
        a = 128,
      },
    },
  },
}
