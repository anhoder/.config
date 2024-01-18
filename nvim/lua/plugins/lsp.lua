local telescope_pickers = require("config.telescope_pickers")
local keys = require("lazyvim.plugins.lsp.keymaps").get()
local telescope_themes = require("telescope.themes")
local keymap_rewrite = {
  ["gr"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_references"
    telescope_pickers.prettyLsp(opts)
  end,

  ["gd"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_definitions"
    telescope_pickers.prettyLsp(opts)
  end,

  ["gI"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_implementations"
    opts["reuse_win"] = true
    telescope_pickers.prettyLsp(opts)
  end,

  ["gy"] = function()
    local opts = telescope_themes.get_ivy()
    opts["picker"] = "lsp_type_definitions"
    opts["reuse_win"] = true
    telescope_pickers.prettyLsp(opts)
  end,
}

return {
  "neovim/nvim-lspconfig",
  init = function()
    for i, key in pairs(keys) do
      if keymap_rewrite[key[1]] then
        keys[i][2] = keymap_rewrite[key[1]]
      end
    end
  end,
}
