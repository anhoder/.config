return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
    ensure_installed = { "lua", "luadoc", "go", "bash", "fish", "php", "phpdoc", "jsdoc", "vimdoc" },
  },
}
