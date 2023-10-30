{ inputs }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; inherit inputs; };
  
}
