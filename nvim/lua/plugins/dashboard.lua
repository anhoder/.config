local Logos = require("utils.logos")

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
  keys = { { "<leader>0", "<cmd>Dashboard<CR>", desc = "Dashboard" } },
  opts = function()
    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
        tabline = false,
        winbar = false,
      },
      config = {
        header = Logos("night_fury"),
        center = {
          {
            action = "Telescope find_files",
            desc = "Find file",
            icon = " ",
            key = "f",
            icon_hl = "DashboardFind",
            key_hl = "DashboardFind",
          },
          {
            action = "Telescope oldfiles",
            desc = "Recent Files",
            key = "r",
            icon = " ",
            icon_hl = "DashboardRecent",
            key_hl = "DashboardRecent",
          },
          {
            action = "Telescope persisted",
            desc = "Sessions",
            key = "s",
            icon = " ",
            icon_hl = "DashboardSession",
            key_hl = "DashboardSession",
          },
          {
            icon = " ",
            icon_hl = "DashboardConfiguration",
            desc = "Configuration",
            key = "i",
            key_hl = "DashboardConfiguration",
            action = "lua require('lazyvim.util').telescope.config_files()()",
          },
          {
            icon = "󰤄 ",
            icon_hl = "DashboardLazy",
            desc = " Lazy",
            key = "l",
            key_hl = "DashboardLazy",
            action = "Lazy",
          },
          {
            icon = " ",
            icon_hl = "DashboardServer",
            desc = "Mason",
            key = "m",
            key_hl = "DashboardServer",
            action = "Mason",
          },
          {
            icon = " ",
            icon_hl = "DashboardQuit",
            desc = "Quit Neovim",
            key = "q",
            key_hl = "DashboardQuit",
            action = "qa",
          },
        },
        footer = function()
          ---@diagnostic disable-next-line: different-requires
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "⚡  eovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
    }

    for _, button in pairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 45 - #button.desc)
      button.icon = button.icon .. string.rep(" ", 5 - #button.icon)
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          ---@diagnostic disable-next-line: different-requires
          require("lazy").show()
        end,
      })
    end
    return opts
  end,
}
