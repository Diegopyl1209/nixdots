{ inputs, pkgs, ... }:
{
  
  home.packages = with pkgs; [
    wl-gammactl
    wl-clipboard
    wf-recorder
    hyprpicker
    wayshot
    swappy
    slurp
    imagemagick
    pavucontrol
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source=~/.config/hypr/settings.conf
    '';
  };

}
