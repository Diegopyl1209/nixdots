{pkgs, ...}: let
  my-python-packages = ps:
    with ps; [
      numpy
      pandas
      psycopg2
      matplotlib
      # TODO: Eliminar
      elasticsearch
      elastic-transport
    ];
in {
  programs = {
    vscode = {
      enable = true;
      package = pkgs.stable.vscode.fhsWithPackages (ps:
        with ps; [
          libGL # Neccesary to debug FabricMC Mods
          flite # Mc Narrator
          usbmuxd
          fontconfig
          freetype
          xorg.libX11
          xorg.libXcursor
          xorg.libXrandr
          xorg.libXi
        ]);
    };

    java = {
      enable = true;
      package = pkgs.openjdk17;
    };

    direnv = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    # Games
    lutris
    heroic
    protonup-qt
    cartridges
    prismlauncher
    ryujinx
    airshipper # veloren

    # GUI Applications
    d-spy
    github-desktop
    transmission_4-gtk
    android-studio
    jetbrains-toolbox
    zoom-us
    jetbrains.idea-ultimate

    # Tools
    bat
    catimg
    eza
    fd
    ripgrep
    socat
    htop
    jq
    acpi
    ffmpeg
    glib
    nodePackages_latest.pnpm
    git-lfs
    moreutils
    mpdris2
    xorg.xev
    playerctl
    recode
    gcc
    zls
    mangohud
    imagemagick
    pavucontrol
    swappy
    micro
    alacritty
    bubblewrap
    fuse-overlayfs
    dwarfs
    psmisc
    toolbox
    logstash

    # Languages
    rustup
    nodejs_20
    typescript
    meson
    (python3.withPackages my-python-packages)
  ];

  xdg.desktopEntries = {
    "heroic" = {
      exec = "heroic %u";
      icon = "heroic";
      name = "Heroic Games Launcher";
      categories = [
        "Game"
      ];
      settings = {
        "StartupWMClass" = "Heroic";
        "MimeType" = "x-scheme-handler/heroic";
        "Type" = "Application";
      };
    };
    "com.heroicgameslauncher.hgl" = {
      name = "Heroic";
      noDisplay = true;
    };
    "Ryujinx" = {
      exec = "ryujinx %u";
      icon = "Ryujinx";
      name = "Ryujinx";
      categories = [
        "Game"
      ];
    };
  };
}
