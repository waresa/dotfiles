return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- Basic configuration - you can expand this based on your needs
      strategies = {
        chat = {
          adapter = "copilot", -- Since you already have Copilot setup
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
      -- Optional: Configure display settings
      display = {
        diff = {
          provider = "mini_diff", -- or "default"
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
    -- Load the plugin when you actually need it
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionAdd",
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n", "v" } },
      { "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Code Companion Chat", mode = { "n", "v" } },
      { "<leader>ca", "<cmd>CodeCompanionAdd<cr>", desc = "Add Code Companion", mode = "v" },
      { "<leader>ch", "<cmd>CodeCompanionChat<cr>", desc = "New Code Companion Chat", mode = { "n", "v" } },
    },
  },
}
