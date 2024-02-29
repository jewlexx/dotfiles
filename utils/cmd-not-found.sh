#!/bin/bash

export PKGFILE_PROMPT_INSTALL_MISSING=1

command_not_found_handler() {
  zx "$DOTFILES/utils/cmd-not-found.mjs" "$1"
}
