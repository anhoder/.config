local Logos = require("utils.logos")
local persisted_util = require("utils.persisted")

return {
  {
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
          -- header = Logos("night_fury"),
          header = Logos("neovim"),
          center = {
            {
              action = "FzfLua files",
              desc = "Find file",
              icon = " ",
              key = "f",
              icon_hl = "DashboardFind",
              key_hl = "DashboardFind",
            },
            {
              action = "FzfLua oldfiles",
              desc = "Recent Files",
              key = "r",
              icon = " ",
              icon_hl = "DashboardRecent",
              key_hl = "DashboardRecent",
            },
            {
              action = persisted_util.pick,
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
              icon = " ",
              icon_hl = "DashboardLazyExtras",
              desc = "LazyExtras",
              key = "x",
              key_hl = "DashboardLazyExtras",
              action = "LazyExtras",
            },
            {
              icon = " ",
              icon_hl = "DashboardMason",
              desc = "Mason",
              key = "m",
              key_hl = "DashboardMason",
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
              "  eovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
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
  },

  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      dashboard = {
        enabled = false,
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          -- Used by the `header` section
          header = Logos("neovim"),
        },
        -- item field formatters
        formats = {
          icon = function(item)
            if item.file and item.icon == "file" or item.icon == "directory" then
              return M.icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "icon" }
          end,
          footer = { "%s", align = "center" },
          header = { "%s", align = "center" },
          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match("^(.*)/(.+)$")
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
          {
            section = "terminal",
            cmd = "ascii-image-converter ~/.config/musicfox.png -C -c --dimensions=60,30",
            random = 10,
            pane = 2,
            indent = 4,
            height = 30,
          },
        },
      },
    },
  },
}
