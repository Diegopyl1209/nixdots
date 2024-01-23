{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland.nix
  ];
  home.packages = with pkgs; [
    wl-clipboard
    xclip
    wf-recorder
    wayshot
    slurp
    swaybg
    swaynotificationcenter
    hyprpicker
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
}
