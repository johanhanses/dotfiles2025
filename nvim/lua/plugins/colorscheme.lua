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
            -- Common dark themes: Mint-Y-Dark, Adwaita-dark, etc.
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
      -- Default to dark if detection fails
      return "dark"
    end

    local appearance = get_os_appearance()

    -- Set up and load theme based on appearance
    require("onedarkpro").setup({
      -- Your theme configuration options here
    })

    if appearance == "dark" then
      vim.cmd("colorscheme onedark")
    else
      vim.cmd("colorscheme onelight") -- Assuming onelight is available
    end

    -- Optional: Set up autocommand to check for system changes (if supported)
    vim.api.nvim_create_autocmd("Signal", {
      pattern = "SIGUSR1",
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
