-- Enable Lua loader for faster startup
vim.loader.enable()

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw (we use fzf-lua for file navigation)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load configuration modules
require("config.options")
require("keymap")
require("completion")
require("formatting")
require("git")
require("lsp")
require("explorer")

-- OS appearance detection for macOS
local function get_os_appearance()
  if vim.fn.has("macunix") == 1 then
    local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      return result:match("Dark") and "dark" or "light"
    end
  elseif vim.fn.has("unix") == 1 then
    -- Linux: check GNOME/GTK theme
    local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      if result:match("dark") then
        return "dark"
      end
    end
  end
  return "light"
end

-- Set background based on OS appearance
vim.o.background = get_os_appearance()

-- Set colorscheme based on background
if vim.o.background == "light" then
  -- Use onenord for light mode (Nord-inspired light theme)
  require('onenord').setup({
    theme = "light",
  })
  vim.cmd.colorscheme("onenord")
else
  -- Use nord for dark mode
  vim.cmd.colorscheme("nord")
end

-- Treesitter highlighting (enable for all buffers)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    pcall(vim.cmd, "TSEnable highlight")
  end,
})

-- Refresh theme on focus (detects OS theme changes)
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    local new_bg = get_os_appearance()
    if vim.o.background ~= new_bg then
      vim.o.background = new_bg
      -- Reload colorscheme based on new background
      if new_bg == "light" then
        require('onenord').setup({
          theme = "light",
        })
        vim.cmd.colorscheme("onenord")
      else
        vim.cmd.colorscheme("nord")
      end
    end
  end,
})
