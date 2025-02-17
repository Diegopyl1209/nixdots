{...}: {
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.command-not-found.enable = false;
}
