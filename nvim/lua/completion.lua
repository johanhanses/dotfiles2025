-- Completion and fuzzy finding

-- fzf-lua setup
local fzf_ok, fzf = pcall(require, "fzf-lua")
if fzf_ok then
  fzf.setup({
    winopts = {
      backdrop = false,
      border = "double",
    },
  })
  -- Register as vim.ui.select handler
  fzf.register_ui_select()
end

-- Copilot setup
local copilot_ok, copilot = pcall(require, "copilot")
if copilot_ok then
  copilot.setup({
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    panel = {
      enabled = true,
    },
  })
end

-- CopilotChat setup
local copilot_chat_ok, copilot_chat = pcall(require, "CopilotChat")
if copilot_chat_ok then
  copilot_chat.setup({})
end
