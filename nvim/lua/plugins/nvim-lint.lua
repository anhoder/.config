return {
  "mfussenegger/nvim-lint",
  event = "LazyFile",
  opts = {
    linters_by_ft = {
      markdown = {},
      dockerfile = { "hadolint" },
    },
  },
}
