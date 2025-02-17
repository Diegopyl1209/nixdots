{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      inputs.stylix.homeManagerModules.stylix
      inputs.base16.nixosModule
      ../features/cli
      ../features/helix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "diegopyl";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/nixos-config";
    };
  };
}
