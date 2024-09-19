{
  config,
  pkgs,
  ...
}: {
  # imports = [
  #   inputs.nix-gaming.nixosModules.steamCompat
  # ];
  hardware.xpadneo.enable = true;
  programs.steam = {
    enable = config.hm.home-manager.gaming.steam.enable;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
