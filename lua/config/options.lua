-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here


-- set tabstop and shiftwidth to 4 for php files
vim.cmd [[
  autocmd FileType php setlocal tabstop=4 shiftwidth=4
]]

-- Disable automatic comment insertion on new lines
vim.cmd [[
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]]

