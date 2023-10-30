{ pkgs, lib,  ... }:
let
    substitute = name: pkgs.writeShellScriptBin name ''
        ${pkgs.kitty}/bin/kitty "$@"
    '';
    
    mkTuple = lib.hm.gvariant.mkTuple;
in 
{
  #programs.kitty.enable = true;
  home = {
    packages = with pkgs; [ kitty (substitute "xterm") ]; #kgx = gnome-console
    sessionVariables.TERMINAL = "xterm";
  };

}
