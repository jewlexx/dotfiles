#!/bin/bash

export PKGFILE_PROMPT_INSTALL_MISSING=1

command_not_found_handler() {
  local cmd="$1"

  zx "$DOTFILES/utils/cmd-not-found.mjs" "$cmd"
}
