{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Archives
    zip
    xz
    unzip
    p7zip

    # CLI Utils
    ripgrep
    jq
    eza
    zoxide
    fzf
    bat
    cava
    feh
    # thefuck
    unrar
    openvpn
    ffmpeg-full
    appimage-run

    # Desktop stuff
    mpd
    ncmpcpp
    mpc-cli
    github-desktop
    #freetube
    #kdenlive
    #krita
    gimp
    nautilus
    #gnome-boxes
    kvmtool
    #hyprpaper
    #inputs.nixpkgs-wayland.packages.${pkgs.system}.swww
    #wl-clipboard
    #cliphist
    #keepassxc
    #keepass-diff
    #wl-clip-persist
    #hyprpicker
    imagemagick
    #grim
    #inputs.nixpkgs-wayland.packages.${system}.slurp
    libreoffice
    ydotool
    lutgen

    # Gui apps
    chromium
    zoom-us
    qdirstat
    mpv
    libreoffice
    zathura
    obsidian
    #nicotine-plus

    # Development
    cargo
    rustfmt
    rustc
    gcc
    raylib
    texliveFull
    commitizen
    python3
    insomnia
    godot_4
    nodejs
    nodePackages.pnpm
    gh
    jdk
    filezilla
    docker
    docker-compose
    distrobox
    direnv
    jetbrains.idea-ultimate
    android-studio
    yt-dlp
    vlc
    alejandra
    pciutils

    # Gaming
    r2modman
    heroic
    lutris
    mangohud
    prismlauncher
    # (prismlauncher.override {withWaylandGLFW = true;})
    blockbench
    wineWowPackages.staging
    winetricks

    # Sound
    pipewire
    # soundux
    lyrebird
    wireplumber
    alsa-lib
    pamixer
    playerctl
    wev
    pavucontrol

    # QT
    qt5.qtwayland
    qt6.qtwayland
    qt6.qmake
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps:
      with ps; [
        raylib
        pkg-config
        openssl
        openssl.dev
      ]);
  };

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
  };
}
