{ lib
, stdenv
, fetchFromGitHub
, util-linux
, fetchurl
, pkgs
,
}:
stdenv.mkDerivation rec {
  version = "1.0-2";
  name = "carburetor-${version}";
  catppuccinVer = "v0.7.0";
  catppuccinTheme = "Catppuccin-Mocha-Standard-Green-Dark";

  catppuccinThemeSrc = fetchurl {
    url = "https://github.com/catppuccin/gtk/releases/download/${catppuccinVer}/${catppuccinTheme}.zip";
    sha256 = "sha256-BTcDGv2bdM9aOYf3MwByEJs1GgNlQItigBKlrcHouk8=";
  };
  
  src = fetchFromGitHub {
    repo = "carburetor";
    owner = "ozwaldorf";
    rev = "eb561878104a0ec51a0df0b7e4f478e27c396559";
    hash = "sha256-aoyxcj+TcLkDakFXQDkVZT0jDWWH4uU8Emp+NXZUU78=";
  };
  
  nativeBuildInputs = [
    pkgs.unzip
  ];

  installPhase = ''
    mkdir -p $out/share/themes/${catppuccinTheme}
    unzip ${catppuccinThemeSrc}
    sh ./patch.sh mocha ./${catppuccinTheme}
    mv ./${catppuccinTheme} $out/share/themes
    cd $out/share/themes
    mv ${catppuccinTheme} Carburetor
  '';

  meta = with lib; {
    description = "Carburetor - An IBM Carbon inspired colorscheme .";
    homepage = "https://github.com/ozwaldorf/carburetor";
    maintainers = with maintainers; [ diegopyl ];
    platforms = platforms.all;
  };
}
