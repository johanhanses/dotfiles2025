return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      popup = {
        winblend = 0,
      },
    },
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
          ".DS_Store",
          -- 'thumbs.db',
          "node_modules",
          ".vscode",
          "build",
        },
        never_show = {},
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- Make neo-tree background transparent
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "NONE" })
      end,
    })

    -- Apply immediately for current colorscheme
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "NONE" })
  end,
}
