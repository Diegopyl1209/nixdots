{pkgs, ...}: {
  imports = [
    ./global

    ./features/stylix
    ./features/desktop/gnome
    ./features/games
  ];

  wallpaper = "samurai.jpg";
  colorscheme = "gruvbox";
}
