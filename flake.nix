{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:MichaelPachec0/spicetify-nix";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    #Lumi.url = "github:bananad3v/Lumi"; #nixvim conf
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar.url = "github:Alexays/Waybar";

    auto-cpufreq = {
      url = "github:adnanhodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    stylix.url = "github:danth/stylix";
    base16.url = "github:SenchoPens/base16.nix";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    getchoo = {
      url = "github:getchoo/nix-exprs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    schizofox = {
      url = "github:schizofox/schizofox";
    };
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    game-rs.url = "github:amanse/game-rs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    wayfreeze.url = "github:jappie3/wayfreeze";
  };

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    username = "diegopyl";
    userfullname = "Diego Peña y Lillo";
    useremail = "diegopyl1209@gmail.com";

    system = "x86_64-linux";

    commonInherits = {
      inherit (nixpkgs) lib;
      inherit self inputs;
      inherit username userfullname useremail;
      inherit system;
    };
  in {
    nixosConfigurations = import ./hosts (
      commonInherits // {isNixOS = true;}
    );

    homeConfigurations = import ./hosts (
      commonInherits // {isNixOS = false;}
    );
  };
}
