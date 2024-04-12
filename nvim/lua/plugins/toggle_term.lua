return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  opts = {
    shade_terminals = false, -- disable background shading
    autochdir = true,
    auto_scroll = false,
    hide_numbers = true,
    start_in_insert = true,
    persist_size = true,
    on_open = function(term)
      vim.defer_fn(function()
        vim.wo[term.window].winbar = ""
      end, 0)
    end,
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      else
        return 20
      end
    end,
  },
}
