{
  pkgs,
  config,
  ...
}: let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "JetBrainsMono"
      "Ubuntu"
      "UbuntuMono"
      "FiraCode"
    ];
  };
in {
  home.packages = [
    nerdfonts
    pkgs.gruvbox-gtk-theme
  ];

  stylix = {
    autoEnable = false;
    polarity = "dark";
    image = ./wallpapers/samurai.jpg;
    base16Scheme = "${config.scheme.outPath}";
    targets = {
      alacritty.enable = true;
      kitty.enable = true;
      gtk.enable = true;
      helix.enable = true;
      bat.enable = true;
      gnome.enable = true;
    };
  };

  stylix.cursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 16;
  };

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans Condensed";
    };
    monospace = {
      package = nerdfonts;
      name = "JetBrainsMono Nerd Font Mono";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
