{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.home-manager.colorscheme
    == "gruvbox") {
    scheme = {
      slug = "biscuit-dark";
      scheme = "Biscuit Dark";
      author = "Biscuit";
      base00 = "202020";
      base01 = "2a2827";
      base02 = "504945";
      base03 = "5a524c";
      base04 = "bdae93";
      base05 = "ddc7a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "ea6962";
      base09 = "e78a4e";
      base0A = "d8a657";
      base0B = "a9b665";
      base0C = "89b482";
      base0D = "7daea3";
      base0E = "d3869b";
      base0F = "bd6f3e";
    };
    home.packages = [
      #(pkgs.callPackage ../../pkgs/gruvbox-plus-icons/package.nix {})
      pkgs.gruvbox-gtk-theme
    ];

    gtk = {
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons; #pkgs.callPackage ../../pkgs/gruvbox-plus-icons/package.nix {};
      };
    };
  };
}
