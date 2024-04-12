{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    base16-kitty = {
      url = "github:diegopyl1209/base16-kitty";
      flake = false;
    };
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    scheme = "${inputs.tt-schemes}/base16/gruvbox-dark-hard.yaml";
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [inputs.nix-topology.overlays.default];
    };
  in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      overlays = import ./overlays {inherit inputs;};
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        diegopyl = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};
          modules = [
            ./nixos/configuration.nix
            (import ./nixos/disko-config.nix {device = "/dev/disk/by-id/ata-WALRAM_512GB_AA000000000000004204";})
            inputs.disko.nixosModules.disko

            inputs.nix-topology.nixosModules.default

          ];
        };
      };

      homeConfigurations = {
        "diegopyl" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {inherit inputs outputs;};
          modules = [
            {inherit scheme;}
            inputs.stylix.homeManagerModules.stylix
            inputs.base16.nixosModule
            inputs.nixvim.homeManagerModules.nixvim
            ./home-manager/home.nix
          ];
        };
      };
    };
  }
