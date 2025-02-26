return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- Default find files (respects .gitignore)
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- Find all files (including hidden/ignored)
    {
      "<leader>fa",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
        })
      end,
      desc = "Find All Files",
    },
    -- Remap default grep to include hidden/ignored files
    {
      "<leader>sg",
      function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--hidden", "--no-ignore" }
          end,
        })
      end,
      desc = "Grep (including hidden/ignored)",
    },
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        ".git/",
      },
    },
  },
} 