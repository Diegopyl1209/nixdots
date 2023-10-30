{
  description = "Home Manager configuration of diegopyl";

  inputs = {

    # Package sources.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    ags.url = "github:Aylur/ags";

    # Channel to follow.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations.diegopyl = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; inherit outputs; };
        modules = [
          ./hosts/diegopyl/configuration.nix
        ];
      };
    
      homeConfigurations."diegopyl" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/diegopyl/home.nix ];
        extraSpecialArgs = { inherit inputs; inherit outputs; };
      };
    };
}
