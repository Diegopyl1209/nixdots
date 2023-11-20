{
  description = "Home Manager configuration of diegopyl";

  inputs = {

    # Package sources.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    ags.url = "github:Aylur/ags";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nur.url = "github:nix-community/NUR";
    rust-overlay.url = "github:oxalica/rust-overlay";
    eww-tray.url = "github:ralismark/eww/tray-3";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # Channel to follow.
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      
      colors = import ./home/shared/cols/verdant.nix { };
    in {
      overlays = import ./overlays { inherit inputs; inherit colors; };

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
        extraSpecialArgs = { inherit inputs; inherit outputs; inherit colors; };
      };
    };
}
