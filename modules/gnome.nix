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
      nix-shell -p glib cinnamon.cinnamon-gsettings-overrides --run 'XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH gsettings set org.cinnamon.desktop.default-applications.terminal exec $TERMINAL'
    '';
  };
in {
  services.xserver = {
    desktopManager.gnome.enable = config.hm.home-manager.gnome.enable;
    displayManager.gdm.enable = config.hm.home-manager.gnome.enable;
  };
  
  services.gnome.gnome-keyring.enable

  environment = {
    systemPackages = with pkgs; [
      configure-terminal-nemo
      cinnamon.nemo-with-extensions
      cinnamon.nemo-fileroller
      gnome-extension-manager
    ];

    gnome.excludePackages =
      (with pkgs; [
        gnome-console
        gnome-photos
        gnome-tour
        gnome-connections
      ])
      ++ (with pkgs.gnome; [
        nautilus
        cheese # webcam tool
        gnome-music
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup
        gnome-shell-extensions
        gnome-maps
        gnome-font-viewer
      ]);
  };
}
