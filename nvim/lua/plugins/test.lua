return {
  "nvim-neotest/neotest",
  optional = true,
  opts = {
    status = { virtual_text = false },
    quickfix = {
      enabled = true,
      open = false,
    },
    output = {
      open_on_run = true,
    },
  },
}
