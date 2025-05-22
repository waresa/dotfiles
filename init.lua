-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Setup conform formatting plugin
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier", "eslint_d" },
    typescript = { "prettier", "eslint_d" },
    -- add other filetypes as needed
  },
  -- Optionally, configure format on save through conform if you prefer
})
local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_on_save,
  pattern = "*",
  callback = function()
    -- If it isnt js or ts then return
    local filetype = vim.bo.filetype
    if filetype ~= "javascript" and filetype ~= "typescript" then
      return
    end
    print("Formatting with conform...")
    require("conform").format({ async = false })
  end,
})
