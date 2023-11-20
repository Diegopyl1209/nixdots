{ config, pkgs, lib, colors }:

lib.makeScope pkgs.newScope (self: with self; {

   carburetor = callPackage ./carburetor.nix { };
   biscuit = callPackage ./biscuit.nix { };
   phocus = callPackage ./phocus { inherit colors; };

})
