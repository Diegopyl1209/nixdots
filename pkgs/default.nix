# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{ pkgs ? (import ../nixpkgs.nix) { }, inputs }: {
  # example = pkgs.callPackage ./example { };
  rxfetch = pkgs.callPackage ./rxfetch.nix { };
  jetbrains-toolbox = pkgs.callPackage ./jetbrains-toolbox.nix { };
  mythemes = pkgs.callPackage ./../home/shared/gtk { };
}
