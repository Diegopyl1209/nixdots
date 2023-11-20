{ inputs, colors }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; inherit inputs; inherit colors; };
  modifications = final: prev: {


    awesome = inputs.nixpkgs-f2k.packages.x86_64-linux.awesome-git;

  };
  
}

