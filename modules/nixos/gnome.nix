{
  config,
  pkgs,
  ...
}: let
  configure-terminal-nemo = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-terminal-nemo";
    executable = true;
    text = ''
      nix-shell -I "nixpkgs=channel:nixos-unstable" -p glib cinnamon.cinnamon-gsettings-overrides --run 'XDG_DATA_DIRS=$GSETTINGS_SCHEMAS_PATH gsettings set org.cinnamon.desktop.default-applications.terminal exec $TERMINAL'
    '';
  };
in {
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;
      startx.enable = true;
    };
  };

  environment = {
    sessionVariables = {
      NAUTILUS_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    };

    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    systemPackages = with pkgs; [
      configure-terminal-nemo
      cinnamon.nemo-with-extensions
      cinnamon.nemo-fileroller
      gnome-extension-manager
    ];

    gnome.excludePackages =
      (with pkgs; [
        #gnome-text-editor
        gnome-console
        gnome-photos
        gnome-tour
        gnome-connections
      ])
      ++ (with pkgs.gnome; [
        nautilus
        cheese # webcam tool
        gnome-music
        #gedit # text editor
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
