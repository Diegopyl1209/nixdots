{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = "github:base16-project/base16-schemes";
      flake = false;
    };
    base16-kitty = {
      url = "github:kdrag0n/base16-kitty";
      flake = false;
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    eww-tray.url = "github:ralismark/eww/tray-3";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    colors = import ./modules/home-manager/verdant.nix {};
    scheme = "${inputs.base16-schemes}/gruvbox-dark-medium.yaml";
    
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.${system}.alejandra;

    overlays = import ./overlays {
      inherit inputs;
      inherit colors;
    };
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      diegopyl = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "diegopyl" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs colors;};
        modules = [
          inputs.stylix.homeManagerModules.stylix
          inputs.base16.nixosModule
          {inherit scheme;}
          {stylix.image = ./stow/wallpapers/.wallpapers/aaaaa.jpg;}
          ./home-manager/home.nix
        ];
      };
    };
  };
}
