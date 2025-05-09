-- return {
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "catppuccin",
--     },
--   },
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     opts = {
--       flavour = "macchiato",
--     },
--   },
-- }

-- return {
--   { "shaunsingh/nord.nvim" },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "nord",
--     },
--   },
-- }

-- return {
--   { "arcticicestudio/nord-vim" },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "nord",
--     },
--   },
-- }

-- return {
--   "neanias/everforest-nvim",
--   name = "everforest",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require("everforest").setup({
--       -- ...
--     })
--
--     vim.cmd([[colorscheme everforest]])
--   end,
-- }

-- return {
--   "folke/tokyonight.nvim",
--   lazy = true,
--   opts = { style = "night" },
-- }
-- return {
--   "olimorris/onedarkpro.nvim",
--   priority = 1000, -- Ensure it loads first
--
--   config = function()
--     vim.cmd("colorscheme onedark")
--   end,
-- }

return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  
  config = function()
    -- Check OS theme preference
    local function get_os_appearance()
      if vim.fn.has("macunix") == 1 then
        -- For macOS
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:match("Dark") and "dark" or "light"
        end
      elseif vim.fn.has("win32") == 1 then
        -- For Windows
        local handle = io.popen("powershell.exe -command \"(Get-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize' -Name AppsUseLightTheme).AppsUseLightTheme\"")
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:match("0") and "dark" or "light"
        end
      elseif vim.fn.has("unix") == 1 then
        -- For Linux/Unix with gsettings (GNOME)
        local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:match("dark") and "dark" or "light"
        end
      end
      
      -- Default to dark if detection fails
      return "dark"
    end
    
    -- local appearance = get_os_appearance()
    
    -- Set up and load theme based on appearance
    require("onedarkpro").setup({
      -- Your theme configuration options here
    })
    
    -- if appearance == "dark" then
      vim.cmd("colorscheme onedark")
    -- else
      -- vim.cmd("colorscheme onelight") -- Assuming onelight is available
    -- end
    
    -- Optional: Set up autocommand to check for system changes (if supported)
    -- vim.api.nvim_create_autocmd("Signal", {
    --   pattern = "SIGUSR1",
    --   callback = function()
    --     local new_appearance = get_os_appearance()
    --     if new_appearance ~= appearance then
    --       appearance = new_appearance
    --       vim.cmd("colorscheme " .. (appearance == "dark" and "onedark" or "onelight"))
    --     end
    --   end,
    -- })
  end,
}

-- return {
--   "oxfist/night-owl.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--  Vy config = function()
--     -- load the colorscheme here
--     require("night-owl").setup()
--     vim.cmd.colorscheme("night-owl")
--   end,
-- }
