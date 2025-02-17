# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./acme.nix
      ./fish.nix
      ./locale.nix
      ./nix.nix
      ./tailscale.nix
      ./gamemode.nix
      ./nix-ld.nix
      ./podman.nix
      ./upower.nix
      ./grub.nix
      ./nix-index.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

  networking.networkmanager.enable = true;

  # Bash shebang
  services.envfs.enable = true;
}
