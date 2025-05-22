return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Add intelephense to your LSP servers
      intelephense = {
        filetypes = { "php" },  -- Explicitly set filetypes
      },
    },
    -- Ensure intelephense is automatically installed
    automatic_installation = true,
  },
} 
