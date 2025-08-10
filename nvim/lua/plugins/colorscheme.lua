return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    -- Check OS theme preference with WSL support
    local function get_os_appearance()
      -- Check if we're running in WSL
      local function is_wsl()
        local handle = io.popen("uname -r 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:lower():match("microsoft") or result:lower():match("wsl")
        end
        return false
      end

      if is_wsl() then
        -- For WSL - Check Windows host theme via PowerShell
        local handle = io.popen(
          "powershell.exe -NoProfile -Command \"try { (Get-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize' -Name AppsUseLightTheme -ErrorAction Stop).AppsUseLightTheme } catch { Write-Output '0' }\" 2>/dev/null"
        )
        if handle then
          local result = handle:read("*a")
          handle:close()
          -- PowerShell returns "0" for dark theme, "1" for light theme
          local theme_value = result:match("(%d+)")
          if theme_value then
            return theme_value == "0" and "dark" or "light"
          end
        end

        -- Fallback: Try cmd.exe approach
        local cmd_handle = io.popen(
          'cmd.exe /c "reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize /v AppsUseLightTheme 2>nul | findstr AppsUseLightTheme" 2>/dev/null'
        )
        if cmd_handle then
          local cmd_result = cmd_handle:read("*a")
          cmd_handle:close()
          -- Look for the registry value (0x0 = dark, 0x1 = light)
          if cmd_result:match("0x0") then
            return "dark"
          elseif cmd_result:match("0x1") then
            return "light"
          end
        end
      elseif vim.fn.has("macunix") == 1 then
        -- For macOS
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:match("Dark") and "dark" or "light"
        end
      elseif vim.fn.has("win32") == 1 then
        -- For native Windows
        local handle = io.popen(
          "powershell.exe -command \"(Get-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize' -Name AppsUseLightTheme).AppsUseLightTheme\""
        )
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:match("0") and "dark" or "light"
        end
      elseif vim.fn.has("unix") == 1 then
        -- For Linux/Unix - Try Cinnamon first, then fallback to GNOME
        -- Check if we're running Cinnamon
        local cinnamon_check = io.popen("pgrep -x cinnamon 2>/dev/null")
        local is_cinnamon = false
        if cinnamon_check then
          local result = cinnamon_check:read("*a")
          cinnamon_check:close()
          is_cinnamon = result and result:len() > 0
        end

        if is_cinnamon then
          -- For Cinnamon desktop (Linux Mint)
          local handle = io.popen("gsettings get org.cinnamon.desktop.interface gtk-theme 2>/dev/null")
          if handle then
            local result = handle:read("*a")
            handle:close()
            -- Check if theme name contains "dark" (case insensitive)
            return result:lower():match("dark") and "dark" or "light"
          end
          -- Alternative: Check Cinnamon theme preference if available
          local handle2 = io.popen("gsettings get org.cinnamon.theme name 2>/dev/null")
          if handle2 then
            local result2 = handle2:read("*a")
            handle2:close()
            return result2:lower():match("dark") and "dark" or "light"
          end
        else
          -- Fallback for other Linux environments (GNOME, etc.)
          local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
          if handle then
            local result = handle:read("*a")
            handle:close()
            return result:match("dark") and "dark" or "light"
          end
          -- Additional fallback: check GTK theme
          local handle2 = io.popen("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
          if handle2 then
            local result2 = handle2:read("*a")
            handle2:close()
            return result2:lower():match("dark") and "dark" or "light"
          end
        end
      end

      -- Default to dark if all detection methods fail
      return "dark"
    end

    local appearance = get_os_appearance()

    -- Set up and load theme based on appearance
    require("onedarkpro").setup({
      -- Minimal configuration to avoid compatibility issues
      colors = {}, -- Override the theme's colors
      highlights = {}, -- Override the theme's highlight groups
      styles = {
        comments = "italic", -- Style that is applied to comments
        keywords = "bold", -- Style that is applied to keywords
        functions = "italic", -- Style that is applied to functions
        conditionals = "italic", -- Style that is applied to conditionals
      },
      options = {
        cursorline = false, -- Use cursorline highlighting?
        transparency = false, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
      },
    })

    if appearance == "dark" then
      vim.cmd("colorscheme onedark")
    else
      vim.cmd("colorscheme onelight")
    end

    -- Create a command to manually refresh the theme
    vim.api.nvim_create_user_command("RefreshTheme", function()
      local new_appearance = get_os_appearance()
      vim.cmd("colorscheme " .. (new_appearance == "dark" and "onedark" or "onelight"))
      print("Theme refreshed: " .. new_appearance)
    end, { desc = "Refresh colorscheme based on OS theme" })

    -- Optional: Set up autocommand to check for system changes
    -- Note: This is more reliable than the SIGUSR1 approach
    local theme_group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })
    vim.api.nvim_create_autocmd("FocusGained", {
      group = theme_group,
      callback = function()
        local new_appearance = get_os_appearance()
        if new_appearance ~= appearance then
          appearance = new_appearance
          vim.cmd("colorscheme " .. (appearance == "dark" and "onedark" or "onelight"))
        end
      end,
    })
  end,
}

-- return {
--   "maxmx03/solarized.nvim",
--   -- "craftzdog/solarized-osaka.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Check OS theme preference
--     local function get_os_appearance()
--       if vim.fn.has("macunix") == 1 then
--         -- For macOS
--         local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
--         if handle then
--           local result = handle:read("*a")
--           handle:close()
--           return result:match("Dark") and "dark" or "light"
--         end
--       elseif vim.fn.has("win32") == 1 then
--         -- For Windows
--         local handle = io.popen(
--           "powershell.exe -command \"(Get-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize' -Name AppsUseLightTheme).AppsUseLightTheme\""
--         )
--         if handle then
--           local result = handle:read("*a")
--           handle:close()
--           return result:match("0") and "dark" or "light"
--         end
--       elseif vim.fn.has("unix") == 1 then
--         -- For Linux/Unix - Try Cinnamon first, then fallback to GNOME
--         -- Check if we're running Cinnamon
--         local cinnamon_check = io.popen("pgrep -x cinnamon 2>/dev/null")
--         local is_cinnamon = false
--         if cinnamon_check then
--           local result = cinnamon_check:read("*a")
--           cinnamon_check:close()
--           is_cinnamon = result and result:len() > 0
--         end
--         if is_cinnamon then
--           -- For Cinnamon desktop (Linux Mint)
--           local handle = io.popen("gsettings get org.cinnamon.desktop.interface gtk-theme 2>/dev/null")
--           if handle then
--             local result = handle:read("*a")
--             handle:close()
--             -- Check if theme name contains "dark" (case insensitive)
--             -- Common dark themes: Mint-Y-Dark, Adwaita-dark, etc.
--             return result:lower():match("dark") and "dark" or "light"
--           end
--           -- Alternative: Check Cinnamon theme preference if available
--           local handle2 = io.popen("gsettings get org.cinnamon.theme name 2>/dev/null")
--           if handle2 then
--             local result2 = handle2:read("*a")
--             handle2:close()
--             return result2:lower():match("dark") and "dark" or "light"
--           end
--         else
--           -- Fallback for other Linux environments (GNOME, etc.)
--           local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
--           if handle then
--             local result = handle:read("*a")
--             handle:close()
--             return result:match("dark") and "dark" or "light"
--           end
--           -- Additional fallback: check GTK theme
--           local handle2 = io.popen("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
--           if handle2 then
--             local result2 = handle2:read("*a")
--             handle2:close()
--             return result2:lower():match("dark") and "dark" or "light"
--           end
--         end
--       end
--       -- Default to light if detection fails (matching solarized's default)
--       return "light"
--     end
--
--     local appearance = get_os_appearance()
--
--     -- Enable true color support
--     vim.o.termguicolors = true
--
--     -- Set background based on OS appearance
--     vim.o.background = appearance
--
--     -- Set up solarized theme
--     require("solarized").setup({
--       -- Your theme configuration options here
--       -- You can customize colors, styles, etc. according to the repo docs
--     })
--
--     -- Load the colorscheme
--     vim.cmd.colorscheme("solarized")
--
--     -- Optional: Set up autocommand to check for system changes (if supported)
--     vim.api.nvim_create_autocmd("Signal", {
--       pattern = "SIGUSR1",
--       callback = function()
--         local new_appearance = get_os_appearance()
--
--         if new_appearance ~= appearance then
--           appearance = new_appearance
--           vim.o.background = appearance
--           vim.cmd.colorscheme("solarized")
--         end
--       end,
--     })
--   end,
-- }

-- return {
--   "projekt0n/github-nvim-theme",
--   name = "github-theme",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Check OS theme preference
--     local function get_os_appearance()
--       if vim.fn.has("macunix") == 1 then
--         -- For macOS
--         local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
--         if handle then
--           local result = handle:read("*a")
--           handle:close()
--           return result:match("Dark") and "dark" or "light"
--         end
--       elseif vim.fn.has("win32") == 1 then
--         -- For Windows
--         local handle = io.popen(
--           "powershell.exe -command \"(Get-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize' -Name AppsUseLightTheme).AppsUseLightTheme\""
--         )
--         if handle then
--           local result = handle:read("*a")
--           handle:close()
--           return result:match("0") and "dark" or "light"
--         end
--       elseif vim.fn.has("unix") == 1 then
--         -- For Linux/Unix - Try Cinnamon first, then fallback to GNOME
--         -- Check if we're running Cinnamon
--         local cinnamon_check = io.popen("pgrep -x cinnamon 2>/dev/null")
--         local is_cinnamon = false
--         if cinnamon_check then
--           local result = cinnamon_check:read("*a")
--           cinnamon_check:close()
--           is_cinnamon = result and result:len() > 0
--         end
--         if is_cinnamon then
--           -- For Cinnamon desktop (Linux Mint)
--           local handle = io.popen("gsettings get org.cinnamon.desktop.interface gtk-theme 2>/dev/null")
--           if handle then
--             local result = handle:read("*a")
--             handle:close()
--             -- Check if theme name contains "dark" (case insensitive)
--             -- Common dark themes: Mint-Y-Dark, Adwaita-dark, etc.
--             return result:lower():match("dark") and "dark" or "light"
--           end
--           -- Alternative: Check Cinnamon theme preference if available
--           local handle2 = io.popen("gsettings get org.cinnamon.theme name 2>/dev/null")
--           if handle2 then
--             local result2 = handle2:read("*a")
--             handle2:close()
--             return result2:lower():match("dark") and "dark" or "light"
--           end
--         else
--           -- Fallback for other Linux environments (GNOME, etc.)
--           local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
--           if handle then
--             local result = handle:read("*a")
--             handle:close()
--             return result:match("dark") and "dark" or "light"
--           end
--           -- Additional fallback: check GTK theme
--           local handle2 = io.popen("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
--           if handle2 then
--             local result2 = handle2:read("*a")
--             handle2:close()
--             return result2:lower():match("dark") and "dark" or "light"
--           end
--         end
--       end
--       -- Default to dark if detection fails
--       return "dark"
--     end
--
--     local appearance = get_os_appearance()
--
--     -- Enable true color support
--     vim.o.termguicolors = true
--
--     -- Set up GitHub theme
--     require("github-theme").setup({
--       options = {
--         -- Compiled file's destination location
--         compile_path = vim.fn.stdpath("cache") .. "/github-theme",
--         compile_file_suffix = "_compiled",
--         hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer
--         hide_nc_statusline = true, -- Override the underline style for non-active statuslines
--         transparent = false, -- Disable setting bg (make neovim's background transparent)
--         terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
--         dim_inactive = false, -- Non focused panes set to alternative background
--         module_default = true, -- Default enable value for modules
--         styles = {
--           comments = "NONE", -- You can customize these as needed
--           functions = "NONE",
--           keywords = "NONE",
--           variables = "NONE",
--           conditionals = "NONE",
--           constants = "NONE",
--           numbers = "NONE",
--           operators = "NONE",
--           strings = "NONE",
--           types = "NONE",
--         },
--         inverse = {
--           match_paren = false,
--           visual = false,
--           search = false,
--         },
--         darken = {
--           floats = true,
--           sidebars = {
--             enable = true,
--             list = {},
--           },
--         },
--       },
--       -- You can add custom palettes, specs, and groups here if needed
--       palettes = {},
--       specs = {},
--       groups = {},
--     })
--
--     -- Load the appropriate colorblind theme based on OS appearance
--     if appearance == "dark" then
--       vim.cmd("colorscheme github_dark_colorblind")
--     else
--       vim.cmd("colorscheme github_light_colorblind")
--     end
--
--     -- Optional: Set up autocommand to check for system changes (if supported)
--     vim.api.nvim_create_autocmd("Signal", {
--       pattern = "SIGUSR1",
--       callback = function()
--         local new_appearance = get_os_appearance()
--         if new_appearance ~= appearance then
--           appearance = new_appearance
--           if appearance == "dark" then
--             vim.cmd("colorscheme github_dark_colorblind")
--           else
--             vim.cmd("colorscheme github_light_colorblind")
--           end
--         end
--       end,
--     })
--   end,
-- }

-- return {
--   "maxmx03/solarized.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Check OS theme preference
--     local function get_os_appearance()
--       if vim.fn.has("macunix") == 1 then
--         -- For macOS
--         local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
--         if handle then
--           local result = handle:read("*a")
--           handle:close()
--           return result:match("Dark") and "dark" or "light"
--         end
--       elseif vim.fn.has("win32") == 1 then
--         -- For Windows
--         local handle = io.popen(
--           "powershell.exe -command \"(Get-ItemProperty -Path 'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize' -Name AppsUseLightTheme).AppsUseLightTheme\""
--         )
--         if handle then
--           local result = handle:read("*a")
--           handle:close()
--           return result:match("0") and "dark" or "light"
--         end
--       elseif vim.fn.has("unix") == 1 then
--         -- For Linux/Unix - Try Cinnamon first, then fallback to GNOME
--         -- Check if we're running Cinnamon
--         local cinnamon_check = io.popen("pgrep -x cinnamon 2>/dev/null")
--         local is_cinnamon = false
--         if cinnamon_check then
--           local result = cinnamon_check:read("*a")
--           cinnamon_check:close()
--           is_cinnamon = result and result:len() > 0
--         end
--         if is_cinnamon then
--           -- For Cinnamon desktop (Linux Mint)
--           local handle = io.popen("gsettings get org.cinnamon.desktop.interface gtk-theme 2>/dev/null")
--           if handle then
--             local result = handle:read("*a")
--             handle:close()
--             -- Check if theme name contains "dark" (case insensitive)
--             -- Common dark themes: Mint-Y-Dark, Adwaita-dark, etc.
--             return result:lower():match("dark") and "dark" or "light"
--           end
--           -- Alternative: Check Cinnamon theme preference if available
--           local handle2 = io.popen("gsettings get org.cinnamon.theme name 2>/dev/null")
--           if handle2 then
--             local result2 = handle2:read("*a")
--             handle2:close()
--             return result2:lower():match("dark") and "dark" or "light"
--           end
--         else
--           -- Fallback for other Linux environments (GNOME, etc.)
--           local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
--           if handle then
--             local result = handle:read("*a")
--             handle:close()
--             return result:match("dark") and "dark" or "light"
--           end
--           -- Additional fallback: check GTK theme
--           local handle2 = io.popen("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
--           if handle2 then
--             local result2 = handle2:read("*a")
--             handle2:close()
--             return result2:lower():match("dark") and "dark" or "light"
--           end
--         end
--       end
--       -- Default to light if detection fails (matching solarized's default)
--       return "light"
--     end
--
--     local appearance = get_os_appearance()
--
--     -- Enable true color support
--     vim.o.termguicolors = true
--
--     -- Set background based on OS appearance
--     vim.o.background = appearance
--
--     -- Set up solarized theme
--     require("solarized").setup({
--       -- Your theme configuration options here
--       -- You can customize colors, styles, etc. according to the repo docs
--     })
--
--     -- Load the colorscheme
--     vim.cmd.colorscheme("solarized")
--
--     -- Optional: Set up autocommand to check for system changes (if supported)
--     vim.api.nvim_create_autocmd("Signal", {
--       pattern = "SIGUSR1",
--       callback = function()
--         local new_appearance = get_os_appearance()
--         if new_appearance ~= appearance then
--           appearance = new_appearance
--           vim.o.background = appearance
--           vim.cmd.colorscheme("solarized")
--         end
--       end,
--     })
--   end,
-- }
