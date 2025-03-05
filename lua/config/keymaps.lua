-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Debugging
map("n", "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Start/Continue Debug" })
map("n", "<leader>dx", "<cmd>DapTerminate<CR>", { desc = "Stop Debug" })
map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step Into" })
map("n", "<leader>du", "<cmd>DapStepOut<CR>", { desc = "Step Out" })

-- Disable format on save for PHP files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Disable autoformat globally
vim.g.autoformat = false

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "<leader>o", "mzo<Esc>`z", { desc = "Insert blank line below" })
vim.keymap.set("n", "<leader>O", "mzO<Esc>`z", { desc = "Insert blank line above" })

-- UUID generation and insertion
vim.keymap.set('n', '<leader>uu', function()
    local uuid = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
    vim.api.nvim_put({uuid}, '', false, true)
end, { desc = 'Insert UUID' })