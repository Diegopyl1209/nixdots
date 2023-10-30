{ inputs, pkgs, ... }:
{

  home.packages = with pkgs; [
    inputs.ags.packages.${system}.default
    swww
    sassc
  ];

}
