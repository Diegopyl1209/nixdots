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
    fzf
    bat
    cava
    feh
    thefuck
    unrar
    openvpn
    ffmpeg-full
    appimage-run

    # Desktop stuff
    mpd
    mpdevil
    github-desktop

    ncmpcpp
    mpc-cli
    flatpak
    #calcure
    transmission_3-gtk
    chiaki
    #kdenlive
    #krita
    gimp
    #gnome.nautilus
    #gnome.gnome-boxes
    kvmtool
    #inputs.nixpkgs-wayland.packages.${pkgs.system}.swww
    #wl-clipboard
    #cliphist
    #keepass
    #keepassxc
    #keepass-diff
    wl-clip-persist
    imagemagick
    grim
    #inputs.nixpkgs-wayland.packages.${system}.slurp
    libreoffice
    ydotool
    lutgen

    # Gui apps
    # authy
    #firefox
    gnumake
    chromium
    element-desktop
    zoom-us
    qdirstat
    mpv
    libreoffice
    zathura
    obsidian
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    
    gnuradio # todo: remove
    
    # Development
    # dotnetCorePackages.sdk_8_0_2xx
    # dotnet-sdk_8
    go
    zls # zig-language-server
    SDL2
    jetbrains.clion
    gcc
    texliveFull
    commitizen
    python3
    insomnia
    godot_4
    nodejs_20
    bun
    yarn
    android-studio
    # gcc
    # libstdcxx5
    # zlib
    # gnumake
    gh
    icu74
    jdk21
    filezilla
    docker
    docker-compose
    distrobox
    # libglibutil
    # glib
    # glibc
    # figma-linux
    direnv
    jetbrains.idea-ultimate
    jetbrains.goland
    # (pkgs.vscode.overrideAttrs (o: let
    #   version = "1.81.1";
    #   plat = "linux-x64";
    # in {
    #   src = pkgs.fetchurl {
    #     name = "VSCode_${version}_${plat}.tar.gz";
    #     url = "https://update.code.visualstudio.com/${version}/${plat}/stable";
    #     sha256 = "sha256-Tqawqu0iR0An3CZ4x3RGG0vD3x/PvQyRhVThc6SvdEg=";
    #   };
    # }))
    yt-dlp
    vlc
    alejandra
    pciutils
    # ngrok

    # Gaming
    steamcmd
    heroic
    cartridges
    gamemode
    lutris
    mangohud
    gamescope
    prismlauncher
    pcsx2
    rpcs3
    # inputs.getchoo.packages.${pkgs.system}.modrinth-app
    wine-staging
    winetricks
    # inputs.game-rs.packages.x86_64-linux.default

    # Sound
    pipewire
    # soundux
    lyrebird
    wireplumber
    alsaLib
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
        jdk21
        pkg-config
        gcc
        raylib
        SDL2
        SDL2.dev
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
