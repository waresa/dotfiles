return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none", -- Disable space mapping to allow leader key to work
        },
      },
    })

    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree reveal<CR>")
    vim.keymap.set("n", "<leader>fe", "<Cmd>Neotree reveal<CR>")
  end,
}
