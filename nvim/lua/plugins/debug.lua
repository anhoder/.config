---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  args = type(args) == "table" and args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

local daputil = require("utils.dap")

return {
  -- nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        enabled = false,
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
        keys = {
          {
            "<leader>du",
            daputil.dapui_toggle,
            desc = "Dap UI",
            mode = { "n", "v" },
          },
          --- @diagnostic disable-next-line
          {
            "<leader>de",
            function()
              require("dapui").eval(nil, { enter = true })
            end,
            desc = "Eval",
            mode = { "n", "v" },
          },
          --- @diagnostic disable-next-line
          {
            "<leader>dfv",
            function()
              require("dapui").float_element("scopes", { enter = true })
            end,
            desc = "Dap float scopes",
            mode = { "n", "v" },
          },
          --- @diagnostic disable-next-line
          {
            "<leader>dfs",
            function()
              require("dapui").float_element("stacks", { enter = true })
            end,
            desc = "Dap float stacks",
            mode = { "n", "v" },
          },
        },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.before.attach.dapui_config = function()
            if not daputil.dapui_opened then
              daputil.dapui_open({ layout = 2 })
            end
          end
          dap.listeners.before.launch.dapui_config = function()
            if not daputil.dapui_opened then
              daputil.dapui_open({ layout = 2 })
            end
          end
          -- dap.listeners.before.event_terminated.dapui_config = function()
          --   dapui_close()
          -- end
          -- dap.listeners.before.event_exited.dapui_config = function()
          --   dapui_close()
          -- end
          -- dap.listeners.before.disconnect.dapui_config = function()
          --   dapui_close()
          -- end
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          virt_text_pos = "eol",
          highlight_changed_variables = true,
          highlight_new_as_changed = true,
          clear_on_continue = true,
        },
      },

      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          triggers = {
            { "<auto>", mode = "nixsoc" },
          },
          spec = {
            ["<leader>d"] = { name = "+debug" },
          },
        },
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_setup = true,
          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {
            function(config)
              -- all sources with no handler get passed here

              -- Keep original functionality
              require("mason-nvim-dap").default_setup(config)
            end,
            php = function(config)
              config.configurations = {
                {
                  type = "php",
                  request = "launch",
                  name = "Listen for Xdebug",
                  port = 9003,
                  -- pathMappings = {
                  --   ["/var/www/html"] = "${workspaceFolder}",
                  --   ["${workspaceFolder}"] = "${workspaceFolder}",
                  -- },
                },
              }
              require("mason-nvim-dap").default_setup(config) -- don't forget this!
            end,
          },
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
            "php",
            "codelldb",
            "cpptools",
            --   "bash",
            --   "python",
          },
        },
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets hover" },
      { "<leader>dh", function() require("dap.ui.widgets").preview() end, desc = "Widgets preview" },
      { "<leader>ds", function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
        end, desc = "Widgets stacks" },
      { "<leader>tL", function() require('dap-go').debug_last_test() end, desc = "Debug Last (Go)" },
    },

    init = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "dap-float",
        callback = function()
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
        end,
      })
    end,
    -- config = function()
    --   local Config = require("lazyvim.config")
    --   vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    --   for name, sign in pairs(Config.icons.dap) do
    --     sign = type(sign) == "table" and sign or { sign }
    --     vim.fn.sign_define(
    --       "Dap" .. name,
    --       --- @diagnostic disable-next-line
    --       { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --     )
    --   end
    -- end,
  },
}
