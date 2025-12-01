-- File explorer (neo-tree)

local neotree_ok, neotree = pcall(require, "neo-tree")
if not neotree_ok then
  return
end

neotree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = true,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
    },
    git_status = {
      symbols = {
        added = "✚",
        modified = "",
        deleted = "✖",
        renamed = "󰁕",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
  },
  window = {
    position = "left",
    width = 35,
    mappings = {
      ["<space>"] = "none",
      ["<cr>"] = "open",
      ["o"] = "open",
      ["l"] = "open",
      ["<right>"] = "open",
      ["h"] = "close_node",
      ["<left>"] = "close_node",
      ["s"] = "open_split",
      ["v"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["a"] = "add",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["H"] = "toggle_hidden",
    },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        "node_modules",
      },
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
  },
  git_status = {
    window = {
      position = "float",
    },
  },
})

-- Keybindings
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree focus<cr>", { desc = "Focus file explorer" })
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status<cr>", { desc = "Git status explorer" })
