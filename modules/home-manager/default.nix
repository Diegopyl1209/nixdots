# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./dunst
    ./git
    ./gnome
    ./hyprland
    ./kitty
    ./music
    ./programs
    ./rofi
    ./shell
    ./stylix
    ./waybar
    ./firefox
  ];
}
