{
  config,
  pkgs,
  lib,
  ...
}:
pkgs.writeShellScriptBin "move_window" ''
  if [ $1 = "special" ]; then
      if [ "$(hyprctl activewindow -j | jq -r ".workspace.id")" = "-99" ]; then
          hyprctl dispatch movetoworkspace e+0
      else
          hyprctl dispatch movetoworkspace special
      fi
  fi''
