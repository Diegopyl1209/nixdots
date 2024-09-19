{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.home-manager.colorscheme
    == "gruvbox") {
    scheme = "${inputs.tt-schemes}/base16/gruvbox-material-dark-hard.yaml";
    home.packages = [
      (pkgs.callPackage ../../pkgs/gruvbox-plus-icons/package.nix {})
      #pkgs.gruvbox-gtk-theme
    ];

    gtk = {
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = (pkgs.callPackage ../../pkgs/gruvbox-plus-icons/package.nix {}); #pkgs.gruvbox-plus-icons;
      };
    };
  };
}
