# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a cross-platform dotfiles repository supporting Linux, macOS, and WSL environments. The repository uses a symlink-based installation system with platform-specific install scripts.

## Key Components

- **Platform-specific install scripts**: `linux-install.sh`, `mac-install.sh`, `wsl-install.sh` - creates symlinks to configuration files in user's home directory
- **ZSH configurations**: Platform-specific zsh configs in `zshrc/{linux,mac,wsl}/`
- **Neovim configuration**: LazyVim-based setup in `nvim/` directory
- **Terminal configurations**: 
  - Tmux config with modular structure (main config + theme/statusline/utility files)
  - Kitty terminal configuration
  - Ghostty terminal configuration (newer addition)
- **System monitoring**: btop configuration for system monitoring
- **RSS reader**: newsboat configuration

## Common Commands

**Installation (run from repository root):**
```bash
# Linux/Ubuntu/Debian
./linux-install.sh

# macOS
./mac-install.sh

# WSL
./wsl-install.sh
```

**Development IDE layout (tmux):**
```bash
# Creates a multi-pane tmux layout for development
./scripts/ide
```

**Tmux configuration reload:**
```bash
# Inside tmux session
<prefix> + r
```

## File Structure Notes

- Configuration files are organized by application in their own directories
- Install scripts handle platform differences (e.g., WSL doesn't install Kitty/Ghostty configs)
- Tmux configuration is modular - main config sources theme, statusline, and utility configs
- Private configurations (like .kube) are expected in a separate `dotfiles-private` repository
- Neovim uses LazyVim as the base configuration with custom plugins in `lua/plugins/`

## Dependencies

- Requires a separate `dotfiles-private` repository at `$HOME/Repos/github.com/johanhanses/dotfiles-private` for sensitive configs
- Git configurations (`.gitconfig`, `.gitignore_global`) are expected to exist in repository root but are not currently present