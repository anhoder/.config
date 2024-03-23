return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
  opts = {
    default_mappings = false,
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
      ancestor = nil, -- use default
    },
  },
}
