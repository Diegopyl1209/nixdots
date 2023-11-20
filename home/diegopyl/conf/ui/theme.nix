{ pkgs, inputs, ... }:

let
  nerdfonts = (pkgs.nerdfonts.override { fonts = [
      "Ubuntu"
      "UbuntuMono"
      "CascadiaCode"
      "FantasqueSansMono"
      "FiraCode"
      "Mononoki"
    ]; });

in {

    
  home.packages = [ nerdfonts ];
  
  home.pointerCursor = {
    x11.enable = true;
    name = "phinger-cursors";
    package = pkgs.phinger-cursors;
    size = 16;
    gtk.enable = true;
  };

    gtk = {
        enable = true;
        theme = {
            name = "phocus";
            package = pkgs.mythemes.phocus;
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
