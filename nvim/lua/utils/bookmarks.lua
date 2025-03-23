local M = {}

local helper = require("utils.helper")

local function get_text(annotation)
  local config = require("bookmarks.config").config
  local pref = string.sub(annotation, 1, 2)
  local ret = config.keywords[pref]
  if ret == nil then
    ret = config.signs.ann.text .. " "
  end
  return ret .. annotation
end

local function bookmarks()
  local cur_project_dir = vim.fn.getcwd()
  local config = require("bookmarks.config").config
  local allmarks = config.cache.data
  local marklist = {}
  for k, ma in pairs(allmarks) do
    if string.sub(k, 0, #cur_project_dir) ~= cur_project_dir then
      goto continue
    end
    for l, v in pairs(ma) do
      table.insert(marklist, {
        filename = k,
        lnum = tonumber(l),
        text = v.a and get_text(v.a) or v.m,
      })
    end
    ::continue::
  end
  return marklist
end

local function delete_bookmark(filepath, lnum)
  local config = require("bookmarks.config").config
  local actions = require("bookmarks.actions")
  local data = config.cache["data"]
  local marks = data[filepath]
  if lnum == -1 then
    marks = nil
    -- check buffer auto_save to file
  end
  for k, _ in pairs(marks or {}) do
    if k == tostring(lnum) then
      marks[k] = nil
      break
    end
  end
  data[filepath] = marks
  actions.saveBookmarks()
end

function M.pick()
  if LazyVim.pick.picker.name == "telescope" then
    return vim.cmd("Telescope bookmarks list")
  elseif LazyVim.pick.picker.name == "fzf" then
    local cur_bufnr = vim.api.nvim_get_current_buf()
    local fzf_lua = require("fzf-lua")
    local util = require("fzf-lua.utils")

    local function hl_validate(hl)
      return not util.is_hl_cleared(hl) and hl or nil
    end

    local function ansi_from_hl(hl, s)
      return util.ansi_from_hl(hl_validate(hl), s)
    end

    local marks = bookmarks()
    local mark_names = {}
    for _, value in pairs(marks) do
      local text = value.text
      local pos =
        ansi_from_hl("FzfLuaDirPart", string.format(" %s:%d", helper.remove_project_prefix(value.filename), value.lnum))
      table.insert(mark_names, text .. pos)
    end

    local function action_cb(selected, cb)
      selected[1] = util.strip_ansi_coloring(selected[1])
      for i, value in ipairs(mark_names) do
        value = util.strip_ansi_coloring(value)
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
            action_cb(selected, function(index)
              local mark = marks[index]
              if not mark then
                return
              end
              vim.cmd(string.format("e +%d %s", mark.lnum, mark.filename))
            end)
          end,
        },
        ["ctrl-d"] = function(selected)
          action_cb(selected, function(index)
            local mark = marks[index]
            if not mark then
              return
            end
            local choice = vim.fn.confirm("Delete '" .. mark.text .. "' bookmark? ", "&Yes\n&No")
            if choice == 1 then
              delete_bookmark(mark.filename, mark.lnum)
              local actions = require("bookmarks.actions")
              actions.detach(cur_bufnr, false)
              actions.refresh(cur_bufnr)
            end
          end)
        end,
      },
    }

    fzf_lua.fzf_exec(mark_names, opts)
  end
end

return M
