{
  pkgs,
  makeWrapper,
  lib,
  ...
}: let
  pname = "autobrr";
  version = "1.45.0";
  name = "${pname}-${version}";
in
  pkgs.stdenv.mkDerivation rec {
    inherit pname name;

    src = pkgs.fetchzip {
      url = "https://github.com/autobrr/autobrr/releases/download/v${version}/autobrr_${version}_linux_x86_64.tar.gz";
      sha256 = "sha256-aF9hJdRiVjh8S3/rf5A9UL8MbNCkA4IVBs6YaTAi9aQ=";
      stripRoot = false;
    };

    phases = ["installPhase"];

    installPhase = ''
      cd $src
      mkdir -p $out/bin
      cp autobrr $out/bin
      cp autobrrctl $out/bin
    '';

    meta = with lib; {
      homepage = "https://autobrr.com/";
      mainProgram = "autobrr";
      description = "The modern autodl-irssi replacement";
      platforms = ["x86_64-linux"];
    };
  }
