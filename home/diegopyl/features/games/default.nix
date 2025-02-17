{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./mangohud.nix
  ];
  home = {
    packages = with pkgs; [
      gamescope
      prismlauncher
      osu-lazer
    ];
  };
}
