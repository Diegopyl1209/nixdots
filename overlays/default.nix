# This file defines overlays
{
  inputs,
  colors,
}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      inherit inputs colors;
    };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    awesome = inputs.nixpkgs-f2k.packages.x86_64-linux.awesome-git;
  };

}
