{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
  ];
  home.packages = with pkgs; [
    dunst
    cliphist
    wl-clipboard
    wf-recorder
    wayshot
    slurp
    swaybg
    hyprpicker
    swappy
    imagemagick
    pavucontrol
    blueberry
    xclip
    copyq
    xwaylandvideobridge
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
}
