local telescope_pickers = require("utils.telescope_pickers")
local telescope_themes = require("telescope.themes")
local lsputil = require("utils.lsp")

-- 匹配数组中的第一个匹配项
local function match_and_replace_keymap(array, value)
  local replaced = false
  for i, v in ipairs(array) do
    if v[1] == value[1] then
      array[i] = value
      replaced = true
    end
  end
  if not replaced then
    table.insert(array, value)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      match_and_replace_keymap(keys, { "gr", "<cmd>Glance references<cr>", desc = "Goto references" })
      match_and_replace_keymap(keys, {
        "gR",
        function()
          local opts = telescope_themes.get_ivy()
          opts["picker"] = "lsp_references"
          telescope_pickers.prettyLsp(opts)
        end,
        desc = "Goto references",
      })
      match_and_replace_keymap(keys, { "gi", "<cmd>Glance implementations<cr>", desc = "Goto implementations" })
      match_and_replace_keymap(keys, {
        "gI",
        function()
          local opts = telescope_themes.get_ivy()
          opts["picker"] = "lsp_implementations"
          opts["reuse_win"] = true
          telescope_pickers.prettyLsp(opts)
        end,
        desc = "Goto implementations",
      })
      match_and_replace_keymap(keys, { "gy", "<cmd>Glance definitions<cr>", desc = "Goto type definitions" })
      match_and_replace_keymap(keys, {
        "gY",
        function()
          local opts = telescope_themes.get_ivy()
          opts["picker"] = "lsp_type_definitions"
          opts["reuse_win"] = true
          telescope_pickers.prettyLsp(opts)
        end,
        desc = "Goto type definitions",
      })
      match_and_replace_keymap(keys, {
        "gd",
        lsputil.goto_def,
        desc = "Goto definition",
      })
      match_and_replace_keymap(keys, {
        "gD",
        function()
          lsputil.definition_handle(function(is_definition)
            local opts = telescope_themes.get_ivy()
            opts["picker"] = "lsp_references"

            if is_definition then
              opts["picker"] = "lsp_definitions"
            end
            telescope_pickers.prettyLsp(opts)
          end)
        end,
        desc = "Goto definition",
      })
      match_and_replace_keymap(keys, { "K", lsputil.hover, desc = "Hover" })
      match_and_replace_keymap(keys, { "<leader>co", vim.lsp.codelens.run, desc = "Run CodeLenAct" })

      vim.tbl_extend("force", opts, {
        single_file_support = true,
        -- inlay_hints = {
        --   enabled = false,
        -- },
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = true,
              lineFoldingOnly = true,
            },
          },
        },
      })
    end,
  },
}
