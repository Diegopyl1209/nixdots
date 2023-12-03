{
  lib,
  stdenv,
  fetchFromGitHub,
  util-linux,
  fetchurl,
  hicolor-icon-theme,
  pkgs,
}:
stdenv.mkDerivation rec {
  version = "1.0-1";
  name = "biscuit-${version}";

  src = fetchFromGitHub {
    repo = "gtk";
    owner = "Biscuit-Colorscheme";
    rev = "024685f1fed60b861e4589993c98103c6af6d906";
    hash = "sha256-lEUqube0mvPLhN1prQ5IypspnJ244byu2IQSn6Vr8QE=";
  };
  
  propagatedBuildInputs = [
    hicolor-icon-theme
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    mkdir -p $out/share/icons/
    mv biscuit-dark biscuit-light $out/share/themes/
    mv papirus-biscuit-dark papirus-biscuit-light $out/share/icons/
  '';

  meta = with lib; {
    description = "Warm and cozy colorscheme for GTK.";
    homepage = "https://github.com/Biscuit-Colorscheme/gtk";
    maintainers = with maintainers; [diegopyl];
    platforms = platforms.all;
  };
}
