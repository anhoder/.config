local version = vim.version()
if version.major <= 0 and version.minor < 10 then
  return {}
end

return {
  "lewis6991/satellite.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    current_only = true,
    winblend = 50,
    zindex = 40,
    excluded_filetypes = {
      "prompt",
      "TelescopePrompt",
      "noice",
      "neo-tree",
      "dashboard",
      "alpha",
      "lazy",
      "mason",
      "DressingInput",
      "neo-tree-popup",
      "sagafinder",
      "saga_codeaction",
      "notify",
    },
    width = 2,
    handlers = {
      cursor = {
        enable = false,
        -- Supports any number of symbols
        symbols = { "⎺", "⎻", "⎼", "⎽" },
        -- symbols = { '⎻', '⎼' }
        -- Highlights:
        -- - SatelliteCursor (default links to NonText
      },
      search = {
        enable = true,
        -- Highlights:
        -- - SatelliteSearch (default links to Search)
        -- - SatelliteSearchCurrent (default links to SearchCurrent)
      },
      diagnostic = {
        enable = true,
        signs = { "-", "=", "≡" },
        min_severity = vim.diagnostic.severity.HINT,
        -- Highlights:
        -- - SatelliteDiagnosticError (default links to DiagnosticError)
        -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
        -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
        -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
      },
      gitsigns = {
        enable = true,
        signs = { -- can only be a single character (multibyte is okay)
          add = "│",
          change = "│",
          delete = "-",
        },
        -- Highlights:
        -- SatelliteGitSignsAdd (default links to GitSignsAdd)
        -- SatelliteGitSignsChange (default links to GitSignsChange)
        -- SatelliteGitSignsDelete (default links to GitSignsDelete)
      },
      marks = {
        enable = false,
        show_builtins = false, -- shows the builtin marks like [ ] < >
        key = "m",
        -- Highlights:
        -- SatelliteMark (default links to Normal)
      },
      quickfix = {
        signs = { "-", "=", "≡" },
        -- Highlights:
        -- SatelliteQuickfix (default links to WarningMsg)
      },
    },
  },
}
