{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  util-linux,
  pkgs,
}:
stdenvNoCC.mkDerivation rec {
  version = "1.0-1";
  name = "rxfetch-${version}";

  src = pkgs.fetchFromGitHub {
    owner = "Mangeshrex";
    repo = "rxfetch";
    rev = "fa70e5aa0eaa72914fc3b170b83a2b67c049cbef";
    sha256 = "Jom9Sy88QGbr3UNccMQgA3eTbHzp8udSE4mrRjyrPDs=";
  };

  buildInputs = with pkgs; [
    procps
  ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/fonts/ttf-material-design-icons
    cp ./ttf-material-design-icons/* $out/share/fonts/ttf-material-design-icons/
    cp rxfetch $out/bin/rxfetch
    chmod +x $out/bin/rxfetch
  '';

  meta = with lib; {
    description = "Custom system fetching tool written in bash script.";
    homepage = "https://github.com/Mangeshrex/rxfetch";
    maintainers = with maintainers; [diegopyl];
    platforms = platforms.all;
  };
}
