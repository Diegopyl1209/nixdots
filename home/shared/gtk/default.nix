{ config, pkgs, lib }:

lib.makeScope pkgs.newScope (self: with self; {

   carburetor = callPackage ./carburetor.nix { };
   biscuit = callPackage ./biscuit.nix { };

})
