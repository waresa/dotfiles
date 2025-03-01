return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      -- PHP Debug configuration
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
      }

      -- Custom highlighting
      vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { ctermbg = 0, fg = "#d8b113", bg = "#31353f" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
      vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

      -- Signs
      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "⬤", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapBreakpointRejected",
        {
          text = "",
          texthl = "DapBreakpointRejected",
          linehl = "DapBreakpointRejected",
          numhl = "DapBreakpointRejected",
        }
      )
      vim.fn.sign_define(
        "DapLogPoint",
        { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )

      -- Add a custom close command that ensures UI is closed
      vim.api.nvim_create_user_command("DapUIClose", function()
        require("dapui").close()
        -- Force close any remaining windows
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")
          if ft:match("^dap") or ft:match("^dapui") then
            vim.api.nvim_win_close(win, true)
          end
        end
      end, {})
    end,
    keys = {
      -- Override the default close command to use our custom close
      {
        "<leader>dx",
        function()
          require("dap").terminate()
          vim.cmd("DapUIClose")
        end,
        desc = "Terminate & Close Debug UI",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "bottom", -- Show UI at the bottom instead of left
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
        force_buffers = true, -- Ensure buffers are cleared when UI is closed
      })

      -- Automatically open DAP UI when debugging starts
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.disconnect["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    },
    opts = {
      enabled = true, -- Enable this plugin
      enabled_commands = true, -- Create commands DapVirtualTextEnable, DapVirtualTextDisable, etc.
      highlight_changed_variables = true, -- Highlight changed values with NvimDapVirtualTextChanged
      highlight_new_as_changed = true, -- Highlight new variables in the same way as changed variables
      show_stop_reason = true, -- Show stop reason when stopped for exceptions
      commented = false, -- Prefix virtual text with comment string
      only_first_definition = true, -- Only show virtual text at first definition
      all_references = false, -- Show virtual text on all references of the variable
      all_frames = false, -- Show virtual text for all stack frames not only current
      virt_text_pos = "eol", -- Position of virtual text, see `:h nvim_buf_set_extmark()`
      virt_text_win_col = nil, -- Position the virtual text at a fixed window column (starting from the first text column)
      virt_lines = false, -- Show virtual lines instead of virtual text (will flicker!)
      virt_text_highlight = "Comment", -- Highlight virtual text with this highlight group
      display_callback = function(variable, buf, stackframe, node, options)
        return " = " .. variable.value
      end,
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "php-debug-adapter")
    end,
  },
}

