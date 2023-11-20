{ lib
, stdenvNoCC
, fetchFromGitHub
, util-linux
, pkgs
,
}:
stdenvNoCC.mkDerivation rec {
  version = "1.0-1";
  name = "morewaita-${version}";

  src = pkgs.fetchFromGitHub {
        owner = "somepaulo";
        repo = "MoreWaita";
        rev = "7c7bf71bf8225742d783ec04985d82fb3bce7cf4";
        sha256 = "sha256-lf9nLA7AH14E/ruYGlklh44OkAZeg86B7+evttDxCNA=";
      };
  
  installPhase = ''
    mkdir -p $out/share/icons
    mv * $out/share/icons
  '';

  meta = with lib; {
    description = "A companion icon theme for Gnome Shell's Adwaita.";
    homepage = "https://github.com/somepaulo/MoreWaita";
    maintainers = with maintainers; [ diegopyl ];
    platforms = platforms.all;
  };
}
