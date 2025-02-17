{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./cliphist.nix
    ./imv.nix
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
