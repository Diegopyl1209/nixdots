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
  cursor-theme = "phinger-cursors";
  cursor-package = pkgs.phinger-cursors;
  #carburetor = (pkgs.callPackage ../../.../shared/gtk/carburetor.nix );

in {

    
  home.packages = [ nerdfonts ];

    gtk = {
        enable = true;
        #iconTheme = {
        #    name = "Papirus-Dark";
        #    package = pkgs.catppuccin-papirus-folders;
        #};
        theme = {
            name = "Carburetor";
            package = pkgs.mythemes.carburetor;
        };
        cursorTheme = {
          name = cursor-theme;
          package = cursor-package;
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
