{pkgs, ...}: let
  pname = "autobrr";
  version = "1.57.0";
  name = "${pname}-${version}";
in
  pkgs.stdenv.mkDerivation {
    inherit pname name;

    src = pkgs.fetchzip {
      url = "https://github.com/autobrr/autobrr/releases/download/v${version}/autobrr_${version}_linux_x86_64.tar.gz";
      sha256 = "sha256-LVzPM+GSDrqUO72YC6RPgmPZRBTu30ZAYLvus4nWkis=";
      stripRoot = false;
    };

    phases = ["installPhase"];

    installPhase = ''
      cd $src
      mkdir -p $out/bin
      cp autobrr $out/bin
      cp autobrrctl $out/bin
    '';

    meta = {
      homepage = "https://autobrr.com/";
      mainProgram = "autobrr";
      description = "The modern autodl-irssi replacement";
      platforms = ["x86_64-linux"];
    };
  }
