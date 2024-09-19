{
  config,
  pkgs,
  ...
}: let
  configure-terminal-nemo = pkgs.writeTextFile {
    name = "configure-nemo-terminal";
    destination = "/bin/configure-terminal-nemo";
    executable = true;
    text = ''
      nix-shell -p glib cinnamon-gsettings-overrides --run 'XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH & gsettings set org.cinnamon.desktop.default-applications.terminal exec kitty'
    '';
  };
in {
  services.xserver = {
    desktopManager.gnome.enable = config.hm.home-manager.gnome.enable;
  };

  services.gnome.gnome-keyring.enable = true;

  environment = {
    systemPackages = with pkgs; [
      configure-terminal-nemo
      nemo-with-extensions
      nemo-fileroller
      gnome-extension-manager
    ];

    gnome.excludePackages = with pkgs; [
      gnome-console
      gnome-photos
      gnome-tour
      gnome-connections
      nautilus
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
}
