local M = {}

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

local function list_sessions()
  local utils = require("persisted.utils")
  local config = require("persisted.config")
  local sep = utils.dir_pattern()
  local persisted = require("persisted")

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

function M.pick()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope persisted")
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local util = require("fzf-lua.utils")
    local sessions = list_sessions()

    local session_names = {}
    for _, value in pairs(sessions) do
      table.insert(session_names, value.name)
    end

    local function hl_validate(hl)
      return not util.is_hl_cleared(hl) and hl or nil
    end

    local function ansi_from_hl(hl, s)
      return util.ansi_from_hl(hl_validate(hl), s)
    end

    local function action_cb(selected, cb)
      for i, value in ipairs(session_names) do
        if selected[1] == value then
          fzf_lua.hide()
          cb(i)
          return
        end
      end
      M.pick()
    end

    local opts = {
      fzf_opts = {
        ["--header"] = string.format(
          "%s%s %s%s",
          ansi_from_hl("FzfLuaDirPart", "<"),
          ansi_from_hl("FzfLuaHeaderText", "delete"),
          ansi_from_hl("FzfLuaDirPart", "ctrl-d"),
          ansi_from_hl("FzfLuaDirPart", ">")
        ),
      },
      fzf_colors = true,
      actions = {
        ["default"] = {
          function(selected)
            local persisted = require("persisted")
            action_cb(selected, function(index)
              vim.schedule(function()
                persisted.load({ session = sessions[index].file_path })
              end)
            end)
          end,
        },
        ["ctrl-d"] = function(selected)
          action_cb(selected, function(index)
            local session = sessions[index]
            local choice = vim.fn.confirm("Remove '" .. session.name .. "' project? ", "&Yes\n&No")
            if choice == 1 then
              vim.fn.delete(vim.fn.expand(session.file_path))
            end
          end)
        end,
      },
    }

    fzf_lua.fzf_exec(session_names, opts)
  end
end

return M
