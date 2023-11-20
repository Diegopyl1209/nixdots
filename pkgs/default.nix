# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{ pkgs, inputs, colors }: {
  # example = pkgs.callPackage ./example { };
  rxfetch = pkgs.callPackage ./rxfetch.nix { };
  morewaita = pkgs.callPackage ./morewaita.nix { };
  jetbrains-toolbox = pkgs.callPackage ./jetbrains-toolbox.nix { };
  hdos = pkgs.callPackage ./hdos.nix { };
  bolt-launcher = pkgs.callPackage ./bolt-launcher.nix { };
  vencord = pkgs.callPackage ./vencord { };
  mythemes = pkgs.callPackage ./../home/shared/gtk { inherit colors; };
}
