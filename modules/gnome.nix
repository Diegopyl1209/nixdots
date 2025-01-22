{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.hm.home-manager.gnome.enable {
    services.xserver = {
      desktopManager.gnome.enable = config.hm.home-manager.gnome.enable;
    };

    services.gnome.gnome-keyring.enable = true;

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    environment = {
      systemPackages = with pkgs; [
        #configure-terminal-nemo
        #nemo-with-extensions
        #nemo-fileroller
        #gnome-extension-manager
        nautilus
        nautilus-python
      ];

      gnome.excludePackages = with pkgs; [
        #gnome-console
        gnome-photos
        gnome-tour
        gnome-connections
        #nautilus
        cheese # webcam tool
        epiphany # web browser
        geary # email reader
        evince # document viewer
        totem # video player
        yelp # Help view
        gnome-font-viewer
        gnome-music
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        gnome-contacts
        gnome-initial-setup
        gnome-shell-extensions
        gnome-maps
      ];
    };
  };
}
