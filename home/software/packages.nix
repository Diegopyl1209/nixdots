{pkgs, ...}: {
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
    ffmpeg-full
    appimage-run
    typst

    # Desktop stuff
    mpd
    mpdevil
    github-desktop

    ncmpcpp
    mpc-cli
    flatpak
    transmission_3-gtk
    chiaki
    gimp
    kvmtool
    imagemagick
    grim
    #inputs.nixpkgs-wayland.packages.${system}.slurp
    libreoffice
    ydotool
    lutgen

    # Gui apps
    gnumake
    chromium
    zoom-us
    qdirstat
    mpv
    libreoffice
    obsidian
    /*
      (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    */

    projectlibre # TODO: Remove
    gnuradio # TODO: remove

    # Development
    go
    rustup
    gcc
    texliveFull
    commitizen
    python3
    insomnia
    android-studio
    gh
    icu74
    jdk21
    filezilla
    distrobox
    direnv
    jetbrains.idea-ultimate
    pkg-config
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
    shipwright
    # inputs.getchoo.packages.${pkgs.system}.modrinth-app
    wine-staging
    winetricks
    # inputs.game-rs.packages.x86_64-linux.default

    # Sound
    pamixer
    playerctl
    pavucontrol
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps:
      with ps; [
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
