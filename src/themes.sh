#!/usr/bin/env bash

SELECTED_THEME="$(tmux show-option -gv @tokyo-night-tmux_theme)"

case $SELECTED_THEME in
"mocha")  # Dark theme
  declare -A THEME=(
    # Base colors
    ["base"]="#1e1e2e"
    ["text"]="#cdd6f4"

    # Regular colors
    ["rosewater"]="#f5e0dc"
    ["flamingo"]="#f2cdcd"
    ["pink"]="#f5c2e7"
    ["mauve"]="#cba6f7"
    ["red"]="#f38ba8"
    ["maroon"]="#eba0ac"
    ["peach"]="#fab387"
    ["yellow"]="#f9e2af"
    ["green"]="#a6e3a1"
    ["teal"]="#94e2d5"
    ["sky"]="#89dceb"
    ["sapphire"]="#74c7ec"
    ["blue"]="#89b4fa"
    ["lavender"]="#b4befe"

    # Surface colors
    ["crust"]="#11111b"
    ["mantle"]="#181825"
    ["surface0"]="#313244"
    ["surface1"]="#45475a"
    ["surface2"]="#585b70"
    ["overlay0"]="#6c7086"
    ["overlay1"]="#7f849c"
    ["overlay2"]="#9399b2"
    ["subtext0"]="#a6adc8"
    ["subtext1"]="#bac2de"
  )
  ;;
"macchiato")  # Medium theme
  declare -A THEME=(
    # Base colors
    ["base"]="#24273a"
    ["text"]="#cad3f5"

    # Regular colors
    ["rosewater"]="#f4dbd6"
    ["flamingo"]="#f0c6c6"
    ["pink"]="#f5bde6"
    ["mauve"]="#c6a0f6"
    ["red"]="#ed8796"
    ["maroon"]="#ee99a0"
    ["peach"]="#f5a97f"
    ["yellow"]="#eed49f"
    ["green"]="#a6da95"
    ["teal"]="#8bd5ca"
    ["sky"]="#91d7e3"
    ["sapphire"]="#7dc4e4"
    ["blue"]="#8aadf4"
    ["lavender"]="#b7bdf8"

    # Surface colors
    ["crust"]="#181926"
    ["mantle"]="#1e2030"
    ["surface0"]="#363a4f"
    ["surface1"]="#494d64"
    ["surface2"]="#5b6078"
    ["overlay0"]="#6e738d"
    ["overlay1"]="#8087a2"
    ["overlay2"]="#939ab7"
    ["subtext0"]="#a5adcb"
    ["subtext1"]="#b8c0e0"
  )
  ;;
"frappe")  # Medium-dark theme
  declare -A THEME=(
    # Base colors
    ["base"]="#303446"
    ["text"]="#c6d0f5"

    # Regular colors
    ["rosewater"]="#f2d5cf"
    ["flamingo"]="#eebebe"
    ["pink"]="#f4b8e4"
    ["mauve"]="#ca9ee6"
    ["red"]="#e78284"
    ["maroon"]="#ea999c"
    ["peach"]="#ef9f76"
    ["yellow"]="#e5c890"
    ["green"]="#a6d189"
    ["teal"]="#81c8be"
    ["sky"]="#99d1db"
    ["sapphire"]="#85c1dc"
    ["blue"]="#8caaee"
    ["lavender"]="#babbf1"

    # Surface colors
    ["crust"]="#232634"
    ["mantle"]="#292c3c"
    ["surface0"]="#414559"
    ["surface1"]="#51576d"
    ["surface2"]="#626880"
    ["overlay0"]="#737994"
    ["overlay1"]="#838ba7"
    ["overlay2"]="#949cbb"
    ["subtext0"]="#a5adce"
    ["subtext1"]="#b5bfe2"
  )
  ;;
"latte")  # Light theme
  declare -A THEME=(
    # Base colors
    ["base"]="#eff1f5"
    ["text"]="#4c4f69"

    # Regular colors
    ["rosewater"]="#dc8a78"
    ["flamingo"]="#dd7878"
    ["pink"]="#ea76cb"
    ["mauve"]="#8839ef"
    ["red"]="#d20f39"
    ["maroon"]="#e64553"
    ["peach"]="#fe640b"
    ["yellow"]="#df8e1d"
    ["green"]="#40a02b"
    ["teal"]="#179299"
    ["sky"]="#04a5e5"
    ["sapphire"]="#209fb5"
    ["blue"]="#1e66f5"
    ["lavender"]="#7287fd"

    # Surface colors
    ["crust"]="#dce0e8"
    ["mantle"]="#e6e9ef"
    ["surface0"]="#ccd0da"
    ["surface1"]="#bcc0cc"
    ["surface2"]="#acb0be"
    ["overlay0"]="#9ca0b0"
    ["overlay1"]="#8c8fa1"
    ["overlay2"]="#7c7f93"
    ["subtext0"]="#6c6f85"
    ["subtext1"]="#5c5f77"
  )
  ;;
*)
  # Default to mocha if no theme is selected
  declare -A THEME=(
    # Base colors
    ["base"]="#1e1e2e"
    ["text"]="#cdd6f4"

    # Regular colors
    ["rosewater"]="#f5e0dc"
    ["flamingo"]="#f2cdcd"
    ["pink"]="#f5c2e7"
    ["mauve"]="#cba6f7"
    ["red"]="#f38ba8"
    ["maroon"]="#eba0ac"
    ["peach"]="#fab387"
    ["yellow"]="#f9e2af"
    ["green"]="#a6e3a1"
    ["teal"]="#94e2d5"
    ["sky"]="#89dceb"
    ["sapphire"]="#74c7ec"
    ["blue"]="#89b4fa"
    ["lavender"]="#b4befe"

    # Surface colors
    ["crust"]="#11111b"
    ["mantle"]="#181825"
    ["surface0"]="#313244"
    ["surface1"]="#45475a"
    ["surface2"]="#585b70"
    ["overlay0"]="#6c7086"
    ["overlay1"]="#7f849c"
    ["overlay2"]="#9399b2"
    ["subtext0"]="#a6adc8"
    ["subtext1"]="#bac2de"
  )
  ;;
esac

# Git status colors (using Catppuccin colors)
THEME['git_green']=${THEME[green]}
THEME['git_mauve']=${THEME[mauve]}
THEME['git_red']=${THEME[red]}
THEME['git_peach']=${THEME[peach]}

# Reset string with new color names
RESET="#[fg=${THEME[text]},bg=${THEME[base]},nobold,noitalics,nounderscore,nodim]"
