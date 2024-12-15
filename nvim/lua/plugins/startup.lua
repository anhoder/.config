local Logos = require("utils.logos")
local persisted = require("persisted")
local utils = require("persisted.utils")
local config = persisted.config

---Escapes special characters before performing string substitution
---@param str string
---@param pattern string
---@param replace string
---@param n? integer
---@return string
---@return integer
local function escape_pattern(str, pattern, replace, n)
  pattern = string.gsub(pattern, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
  replace = string.gsub(replace, "[%%]", "%%%%") -- escape replacement

  return string.gsub(str, pattern, replace, n)
end

local function pick()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope persisted")
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local util = require("fzf-lua.utils")

    local function hl_validate(hl)
      return not util.is_hl_cleared(hl) and hl or nil
    end

    local function ansi_from_hl(hl, s)
      return util.ansi_from_hl(hl_validate(hl), s)
    end

    local opts = {
      fzf_opts = {
        ["--header"] = string.format(
          ":: <%s> to %s",
          ansi_from_hl("FzfLuaHeaderBind", "ctrl-d"),
          ansi_from_hl("FzfLuaHeaderText", "delete")
        ),
      },
      fzf_colors = true,
      actions = {
        ["default"] = {
          function(selected)
            fzf_lua.files({ cwd = selected[1] })
          end,
        },
        -- ["ctrl-d"] = function(selected)
        --   local path = selected[1]
        --   local choice = vim.fn.confirm("Delete '" .. path .. "' project? ", "&Yes\n&No")
        --   if choice == 1 then
        --     history.delete_project({ value = path })
        --   end
        --   pick()
        -- end,
      },
    }

    fzf_lua.fzf_exec(results, opts)
  end
end

local function list_sessions()
  local sep = utils.dir_pattern()

  local sessions = {}
  for _, session in pairs(persisted.list()) do
    local session_name = escape_pattern(session, config.save_dir, "")
      :gsub("%%", sep)
      :gsub(vim.fn.expand("~"), sep)
      :gsub("//", "")
      :sub(1, -5)

    if vim.fn.has("win32") == 1 then
      session_name = escape_pattern(session_name, sep, ":", 1)
      session_name = escape_pattern(session_name, sep, "\\")
    end

    local branch, dir_path

    if string.find(session_name, "@@", 1, true) then
      local splits = vim.split(session_name, "@@", { plain = true })
      branch = table.remove(splits, #splits)
      dir_path = vim.fn.join(splits, "@@")
    else
      dir_path = session_name
    end

    table.insert(sessions, {
      ["name"] = session_name,
      ["file_path"] = session,
      ["branch"] = branch,
      ["dir_path"] = dir_path,
    })
  end
  return sessions
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = false,
      },
    },
  },
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
          header = Logos("night_fury"),
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
            -- {
            --   action = "SessionSelect",
            --   desc = "Sessions",
            --   key = "s",
            --   icon = " ",
            --   icon_hl = "DashboardSession",
            --   key_hl = "DashboardSession",
            -- },
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
}
