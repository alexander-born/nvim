-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.shiftwidth = 4 -- Size of an indent
opt.tabstop = 4 -- Number of spaces tabs count for
opt.clipboard = nil -- Disable clipboard sync which lazyvim enables by default...
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
