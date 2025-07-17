return {
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Ensure .jsx files are recognized correctly
      vim.filetype.add({
        extension = {
          jsx = "javascriptreact",
        },
        filename = {
          [".jsx"] = "javascriptreact",
        },
        pattern = {
          [".*%.jsx$"] = "javascriptreact",
        },
      })
    end,
  },
}