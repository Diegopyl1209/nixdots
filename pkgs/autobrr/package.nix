{pkgs, ...}: let
  pname = "autobrr";
  version = "1.58.0";
  name = "${pname}-${version}";
in
  pkgs.stdenv.mkDerivation {
    inherit pname name;

    src = pkgs.fetchzip {
      url = "https://github.com/autobrr/autobrr/releases/download/v${version}/autobrr_${version}_linux_x86_64.tar.gz";
      sha256 = "sha256-Nbo5QHqSUVSbb/Is7jZzLVBnz7Krc0f+r6UcN1GHQl0=";
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
