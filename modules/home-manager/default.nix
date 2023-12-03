{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./wallpaper.nix
    ./conf
    ./bin
    ./misc
  ];

  wallpaper = ../../stow/wallpapers/.wallpapers/aaaaa.jpg;
}
