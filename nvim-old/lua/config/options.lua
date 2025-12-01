-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.wrap = true
vim.lsp.inlay_hint.enable(false)
vim.opt.relativenumber = false

-- Disable listchars symbols for spaces and tabs
vim.opt.list = false

-- vim.opt.clipboard = "unnamedplus"

-- vim.g.clipboard = {
--   name = "wl-clipboard",
--   copy = {
--     ["+"] = "wl-copy",
--     ["*"] = "wl-copy",
--   },
--   paste = {
--     ["+"] = "wl-paste",
--     ["*"] = "wl-paste",
--   },
-- }
