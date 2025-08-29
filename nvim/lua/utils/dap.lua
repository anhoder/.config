local M = {}

local dapui_opened = false

function M.dapui_close()
  dapui_opened = false
  require("dapui").close()
end

function M.dapui_open(opts)
  opts = opts or {}

  dapui_opened = true
  opts.reset = true
  require("dapui").open(opts)
  if not opts or not opts.layout then
    vim.cmd("Neotree close")
  end
end

function M.dapui_toggle()
  if dapui_opened then
    M.dapui_close()
  else
    M.dapui_open()
  end
end

function M.get_eval_expression(expr)
  local mode = vim.api.nvim_get_mode()
  if mode.mode == "v" then
    -- [bufnum, lnum, col, off]; 1-indexed
    local start = vim.fn.getpos("v")
    local end_ = vim.fn.getpos(".")

    local start_row = start[2]
    local start_col = start[3]

    local end_row = end_[2]
    local end_col = end_[3]

    if start_row == end_row and end_col < start_col then
      end_col, start_col = start_col, end_col
    elseif end_row < start_row then
      start_row, end_row = end_row, start_row
      start_col, end_col = end_col, start_col
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", false)

    -- buf_get_text is 0-indexed; end-col is exclusive
    local lines = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
    return table.concat(lines, "\n")
  end
  expr = expr or "<cexpr>"
  if type(expr) == "function" then
    return expr()
  else
    return vim.fn.expand(expr)
  end
end

function M.find_var(scopes, expression)
  for _, s in ipairs(scopes) do
    for _, var in ipairs(s.variables or {}) do
      if var.name == expression or var.name == "$" .. expression then
        return var
      end
    end
  end
  return nil
end

function M.copy_eval_expression()
  local session = require("dap").session()
  if not session then
    vim.notify("No active session", vim.log.levels.WARN)
    return nil
  end
  local expression = M.get_eval_expression()

  local frame = session.current_frame or {}
  local scopes = frame.scopes or {}

  local var = M.find_var(scopes, expression)
  if var then
    expression = var.name
    if not expression:match("%$") then
      expression = "$" .. var.name
    end
  else
    if expression:match("this%-%>") and not expression:match("%$") then
      expression = "$" .. expression
    end
  end

  if not expression:match("json_encode") then
    expression = "json_encode(" .. expression .. ", JSON_UNESCAPED_UNICODE)"
  end

  local args = {
    expression = expression,
    context = "repl",
  }

  session:evaluate(args, function(err, resp)
    if err then
      vim.notify('Cannot evaluate "' .. expression .. '"!', vim.log.levels.WARN)
    elseif resp and resp.result then
      local result = vim.fn.trim(resp.result, '"', 0)
      vim.fn.setreg("+", result) -- "+ 寄存器就是系统剪切板
      vim.notify("copied: " .. result)

      -- local attributes = (resp.presentationHint or {}).attributes or {}
      -- if resp.variablesReference > 0 or vim.tbl_contains(attributes, "rawString") then
      --   vim.fn.setreg("+", resp.result) -- "+ 寄存器就是系统剪切板
      -- else
      --   vim.fn.setreg("+", resp.result) -- "+ 寄存器就是系统剪切板
      -- end
    end
  end)
end

return M
