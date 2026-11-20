#!/bin/bash

for cask in $(brew list --cask); do
  app=$(brew info --cask --json=v2 "$cask" | grep -o '"app":\[[^]]*\]' | sed -E 's/"app":\["([^"]+)".*/\1/')
  if [[ -n "$app" && ! -e "/Applications/$app" && ! -e "$HOME/Applications/$app" ]]; then
    echo "$cask (missing: $app)"
  fi
done
