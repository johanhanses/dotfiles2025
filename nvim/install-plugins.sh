#!/bin/bash
# Install Neovim plugins and LSP servers
# Plugins are installed to ~/.local/share/nvim/site/pack/plugins/start/

set -e

# Install LSP servers and formatters
echo "Installing LSP servers and formatters..."
echo ""

# Node-based tools
if command -v npm &> /dev/null; then
  echo "Installing npm packages..."
  npm i -g typescript typescript-language-server \
    vscode-langservers-extracted \
    @tailwindcss/language-server \
    @biomejs/biome \
    prettier
else
  echo "npm not found, skipping Node-based LSP servers"
fi

# Homebrew tools (macOS)
if command -v brew &> /dev/null; then
  echo ""
  echo "Installing Homebrew packages..."
  brew install lua-language-server stylua
else
  echo "Homebrew not found, skipping brew packages"
fi

echo ""
echo "Installing Neovim plugins..."
PACK_DIR="$HOME/.local/share/nvim/site/pack/plugins/start"
echo "Installing plugins to: $PACK_DIR"
mkdir -p "$PACK_DIR"
cd "$PACK_DIR"

# Function to clone or update a plugin
install_plugin() {
  local repo="$1"
  local name=$(basename "$repo" .git)

  if [ -d "$name" ]; then
    echo "Updating $name..."
    cd "$name"
    git pull --ff-only
    cd ..
  else
    echo "Installing $name..."
    git clone --depth 1 "https://github.com/$repo.git"
  fi
}

# Core plugins
install_plugin "neovim/nvim-lspconfig"
install_plugin "nvim-treesitter/nvim-treesitter"
install_plugin "stevearc/conform.nvim"
install_plugin "ibhagwan/fzf-lua"

# Git integration
install_plugin "NeogitOrg/neogit"
install_plugin "ruifm/gitlinker.nvim"

# AI assistance
install_plugin "zbirenbaum/copilot.lua"
install_plugin "CopilotC-Nvim/CopilotChat.nvim"

# Colorscheme
install_plugin "navarasu/onedark.nvim"

# File explorer
install_plugin "nvim-neo-tree/neo-tree.nvim"
install_plugin "MunifTanjim/nui.nvim"
install_plugin "nvim-tree/nvim-web-devicons"

# Dependencies
install_plugin "nvim-lua/plenary.nvim"

echo ""
echo "======================================"
echo "Installation complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "  1. Open Neovim"
echo "  2. Run :TSUpdate to install treesitter parsers"
echo "  3. Run :Copilot auth to authenticate with GitHub Copilot"
echo ""
echo "Installed LSP servers:"
echo "  - typescript-language-server (TypeScript/JavaScript/React)"
echo "  - vscode-langservers-extracted (ESLint, HTML, CSS, JSON)"
echo "  - tailwindcss-language-server (Tailwind CSS)"
echo "  - biome (JS/TS linting/formatting)"
echo "  - lua-language-server (Lua)"
echo ""
echo "Installed formatters:"
echo "  - prettier"
echo "  - stylua"
echo ""
echo "Optional (install manually if needed):"
echo "  brew install gopls rust-analyzer clangd zls pyright"
