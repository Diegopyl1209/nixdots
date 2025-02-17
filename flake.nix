{
  description = "My NixOS configuration";

  inputs = {
    # Nix ecosystem
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    base16 = {
      url = "github:SenchoPens/base16.nix";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;
    nixosModules = {
      default = import ./modules/nixos;
    };
    homeManagerModules = {
      default = import ./modules/home-manager;
    };

    overlays = import ./overlays {inherit inputs outputs;};

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      # Main desktop
      desktop = lib.nixosSystem {
        modules = [./hosts/desktop];
        specialArgs = {
          inherit inputs outputs;
        };
      };
      # Personal laptop
      laptop = lib.nixosSystem {
        modules = [./hosts/laptop];
        specialArgs = {
          inherit inputs outputs;
        };
      };
      # Server
      server = lib.nixosSystem {
        modules = [./hosts/server];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      # Standalone HM only

      # Main desktop
      "diegopyl@desktop" = lib.homeManagerConfiguration {
        modules = [./home/diegopyl/desktop.nix ./home/diegopyl/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
      # Personal laptop
      "diegopyl@laptop" = lib.homeManagerConfiguration {
        modules = [./home/diegoypl/laptop.nix ./home/diegopyl/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
      # Server
      "digopyl@server" = lib.homeManagerConfiguration {
        modules = [./home/diegoypl/server.nix ./home/diegopyl/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
