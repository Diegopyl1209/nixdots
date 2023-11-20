{ pkgs, outputs, overlays, lib, inputs, ... }:
{
  imports = [
    ./i18n.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./sound.nix
    ./virtualisation.nix
  ];
  
  
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  security.polkit.enable = true;
  nixpkgs.config.allowUnfree = true;
  
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;
      substituters = [ 
        "https://nix-gaming.cachix.org" 
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [ 
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
       ];

    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };
    optimise.automatic = true;
  };
  system = {
    copySystemConfiguration = false;
    stateVersion = "23.05"; 
  };
}
