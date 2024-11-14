#!/usr/bin/env bash

# Get the current directory
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the theme colors
source "$CURRENT_DIR/themes.sh"

status_left_color() {
  if [[ "$(tmux show-option -gpv client_prefix)" == "1" ]]; then
    echo "${THEME[green]}"   # when prefix is pressed
  else
    echo "${THEME[lavender]}"
  fi
}

status_left_color
