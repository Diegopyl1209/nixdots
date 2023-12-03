{
  pkgs,
  inputs,
  config,
  ...
}: let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "Ubuntu"
      "UbuntuMono"
      "CascadiaCode"
      "FantasqueSansMono"
      "FiraCode"
      "Mononoki"
    ];
  };
in {
  home.packages = [nerdfonts pkgs.hicolor-icon-theme];
  
  stylix.polarity = "dark";
  stylix.base16Scheme = "${config.scheme}";
  stylix.cursor = {
    name = "phinger-cursors";
    package = pkgs.phinger-cursors;
    size = 16;
  };
  
  stylix.fonts = {
    serif = {
      package = nerdfonts;
      name = "Ubuntu Nerd Font";
    };

    sansSerif = {
      package = nerdfonts;
      name = "Ubuntu Nerd Font";
    };

    monospace = {
      package = nerdfonts;
      name = "UbuntuMono Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

 # home.pointerCursor = {
 #   x11.enable = true;
 #   name = "phinger-cursors";
 #   package = pkgs.phinger-cursors;
    #size = 16;
 #   gtk.enable = true;
 # };

  gtk = {
    enable = true;
    theme = {
      name = "Carburetor";
      package = pkgs.mythemes.carburetor;
    };
    iconTheme = {
      #name = "Tela-dark";
      #package = pkgs.tela-icon-theme;
      name = "papirus-biscuit-dark";
      package = pkgs.mythemes.biscuit;
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
