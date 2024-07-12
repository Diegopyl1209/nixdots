{
  inputs,
  isNixOS,
  lib,
  system,
  username,
  useremail,
  ...
}: let
  mkHost = host: let
    pkgsStable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    extraSpecialArgs = {
      inherit inputs host isNixOS username useremail pkgsStable pkgs;
    };

    homeManagerImports = [
      ./${host}/home.nix # host specific home-manager configuration
      ../home
      ../options/home
      inputs.schizofox.homeManagerModule
      inputs.stylix.homeManagerModules.stylix
      inputs.base16.nixosModule
      inputs.nixvim.homeManagerModules.nixvim
    ];
  in
    if isNixOS
    then
      lib.nixosSystem {
        specialArgs = extraSpecialArgs;

        modules = [
          ./${host} # host specific configuration
          ./${host}/hardware-configuration.nix # host specific hardware configuration
          ../modules
          ../pkgs
          ../options/nixos
          inputs.nur.nixosModules.nur
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "back";

              inherit extraSpecialArgs;

              users.${username} = {
                imports = homeManagerImports;
                programs.home-manager.enable = true;
              };
            };
          }
          # alias for home-manager
          (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
        ];
      }
    else
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit extraSpecialArgs;
        inherit pkgs;

        modules = homeManagerImports;
      };
in
  builtins.listToAttrs (map (host: {
    name = "${host}";
    value = mkHost host;
  }) ["pc" "laptop"])
