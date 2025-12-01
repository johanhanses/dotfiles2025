return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
  opts = {
    -- Terminal Configuration
    terminal = {
      split_side = "right", -- "left" or "right"
      split_width_percentage = 0.40,
    },

    -- Diff Integration
    diff_opts = {
      vertical_split = false,
      open_in_current_tab = true,
      keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
    },
  },
  config = function(_, opts)
    require("claudecode").setup(opts)

    -- Make Claude Code terminal background transparent
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        -- Standard terminal highlight groups
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

        -- Snacks.nvim terminal specific groups (if they exist)
        vim.api.nvim_set_hl(0, "SnacksNotifierInfo", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksNotifierWarn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksNotifierError", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksNotifierDebug", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksNotifierTrace", { bg = "NONE" })

        -- Terminal specific groups
        vim.api.nvim_set_hl(0, "Terminal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "TerminalNormal", { bg = "NONE" })
      end,
    })

    -- Also set immediately for current session
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "Terminal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TerminalNormal", { bg = "NONE" })
  end,
}
