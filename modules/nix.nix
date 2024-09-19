{pkgs, ...}: {
  # Nix
  nix = {
    # package = lib.mkIf (host != "server") pkgs.nixVersions.latest;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-gaming.cachix.org"
        "https://isabelroses.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://game-rs.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "isabelroses.cachix.org-1:mXdV/CMcPDaiTmkQ7/4+MzChpOe6Cb97njKmBQQmLPM="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "game-rs.cachix.org-1:fsu+ijfA2GCUE2QX0af80D7x9PCZS79EZbqwtOtlIhA="
      ];
    };
  };
  # Nixpkgs
  nixpkgs = {
    overlays = [
      #inputs.sddm-sugar-candy-nix.overlays.default
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

  environment.profiles = [
    "$HOME/.local/share/flatpak/exports/share"
    "/var/lib/flatpak/exports/share"
  ];

  # Nix-ld
  programs.nix-ld = {
    enable = true;
    # deps from steam-run
    libraries = with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curl
      dbus
      expat
      fontconfig
      freetype
      fuse3
      gdk-pixbuf
      glib
      gtk3
      icu
      libGL
      libappindicator-gtk3
      libdrm
      libglvnd
      libnotify
      libpulseaudio
      libunwind
      libusb1
      libuuid
      libxkbcommon
      libxml2
      mesa
      nspr
      nss
      openssl
      pango
      pipewire
      stdenv.cc.cc
      systemd
      vulkan-loader
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.libxkbfile
      xorg.libxshmfence
      zlib
    ];
  };
}
