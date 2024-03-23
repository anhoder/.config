local M = {}

function M.cursor_not_on_result(bufnr, cursor, result)
  local target_uri = result.targetUri or result.uri
  local target_range = result.targetRange or result.range

  local target_bufnr = vim.uri_to_bufnr(target_uri)
  local target_row_start = target_range.start.line + 1
  local target_row_end = target_range["end"].line + 1
  local target_col_start = target_range.start.character + 1
  local target_col_end = target_range["end"].character + 1

  local current_bufnr = bufnr
  local current_range = cursor
  local current_row = current_range[1]
  local current_col = current_range[2] + 1 -- +1 because if cursor highlights first character its a column behind

  return target_bufnr ~= current_bufnr
    or current_row < target_row_start
    or current_row > target_row_end
    or (current_row == target_row_start and current_col < target_col_start)
    or (current_row == target_row_end and current_col > target_col_end)
end

---@param handler fun(is_definition: boolean)
function M.definition_handle(handler)
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local current_bufnr = vim.api.nvim_get_current_buf()

  local params = vim.lsp.util.make_position_params(0)
  params.context = { includeDeclaration = false }

  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, _, _)
    if err then
      vim.notify(err.message, vim.log.levels.ERROR)
      return
    end

    local is_definition = false
    -- I assume that the we care about only one (first) definition
    if result and #result > 0 then
      local first_definition = result[1]
      if M.cursor_not_on_result(current_bufnr, current_cursor, first_definition) then
        is_definition = true
      end
    end

    handler(is_definition)
  end)
end

function M.gopls_config()
  return {
    -- cmd = {
    --   "gopls",
    --   "-remote=127.0.0.1:37374",
    -- },
    single_file_support = true,
    settings = {
      gopls = {
        gofumpt = true,
        buildFlags = { "-tags=wireinject" },
        analyses = {
          fieldalignment = false,
          ST1000 = false,
          ST1003 = false,
          SA4006 = false,
        },
        usePlaceholders = false,
      },
    },
  }
end

return M
