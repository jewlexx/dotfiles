if $IS_WSL; then
  if [ -f "$HOME/.dotfiles/wsl/WSLHostPatcher.exe" ]; then
    echo "Patching WSL host file..."
    "$HOME/.dotfiles/wsl/WSLHostPatcher.exe"
  else
    echo "WSLHostPatcher.exe not found, skipping patching."
  fi
fi

# Alias to open file explorer
if $IS_WSL; then
  alias xdg-open="wslview"
fi

if command -v sfsu.exe >/dev/null; then
  znap eval sfsu 'sfsu.exe hook --shell zsh'
fi
