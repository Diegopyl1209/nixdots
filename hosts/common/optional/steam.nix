{
  inputs,
  config,
  pkgs,
  ...
}: {
  hardware.xpadneo.enable = true;
  programs.steam = {
    enable = true;
    # platformOptimizations.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
