-- Keybindings

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Escape alternatives
map("i", "<F1>", "<Esc>", opts)
map("n", "<F1>", "<Esc>", opts)

-- Buffer navigation
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Tab navigation
map("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })

-- Quickfix navigation
map("n", "[q", "<cmd>cprevious<cr>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })

-- Diagnostics navigation
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- FzfLua bindings
local fzf_ok, fzf = pcall(require, "fzf-lua")
if fzf_ok then
  map("n", "<leader><leader>", fzf.files, { desc = "Find files" })
  map("n", "<leader>ff", fzf.files, { desc = "Find files" })
  map("n", "<leader>fs", fzf.live_grep, { desc = "Live grep" })
  map("n", "<leader>bb", fzf.buffers, { desc = "List buffers" })
  map("n", "<leader>tf", fzf.tabs, { desc = "List tabs" })
  -- Git
  map("n", "<leader>gf", fzf.git_files, { desc = "Git files" })
  map("n", "<leader>gl", fzf.git_commits, { desc = "Git log" })
  map("n", "<leader>gb", fzf.git_branches, { desc = "Git branches" })
end

-- Neogit
local neogit_ok, neogit = pcall(require, "neogit")
if neogit_ok then
  map("n", "<leader>gg", function() neogit.open() end, { desc = "Open Neogit" })
end

-- LSP keybindings (set on attach)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local function buf_map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Hover and info
    buf_map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    buf_map("n", "<leader>ci", vim.lsp.buf.hover, "Hover info")

    -- Go to definition/declaration
    buf_map("n", "<leader>cd", vim.lsp.buf.definition, "Go to definition")
    buf_map("n", "<leader>cD", vim.lsp.buf.declaration, "Go to declaration")
    buf_map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    buf_map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

    -- References and implementations
    buf_map("n", "<leader>cu", vim.lsp.buf.references, "Find references")
    buf_map("n", "gr", vim.lsp.buf.references, "Find references")
    buf_map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")

    -- Rename and code actions
    buf_map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
    buf_map("v", "<leader>ca", vim.lsp.buf.code_action, "Code actions")

    -- Workspace
    buf_map("n", "<leader>cws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
    buf_map("n", "<leader>cwd", vim.diagnostic.setloclist, "Workspace diagnostics")

    -- Signature help
    buf_map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
  end,
})

-- Copilot Chat (if available)
local copilot_chat_ok, _ = pcall(require, "CopilotChat")
if copilot_chat_ok then
  map("n", "<leader>ac", "<cmd>CopilotChat<cr>", { desc = "Copilot Chat" })
  map("v", "<leader>ac", "<cmd>CopilotChat<cr>", { desc = "Copilot Chat" })
  map("n", "<leader>ae", "<cmd>CopilotChatExplain<cr>", { desc = "Copilot Explain" })
  map("v", "<leader>ae", "<cmd>CopilotChatExplain<cr>", { desc = "Copilot Explain" })
  map("n", "<leader>ar", "<cmd>CopilotChatReview<cr>", { desc = "Copilot Review" })
  map("v", "<leader>ar", "<cmd>CopilotChatReview<cr>", { desc = "Copilot Review" })
end

-- Make
map("n", "<F5>", "<cmd>make<cr>", { desc = "Run make" })

-- Tag jumping
map("n", "<leader>t", "<C-]>", { desc = "Jump to tag" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", opts)
