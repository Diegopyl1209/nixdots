{
  pkgs,
  lib,
  stdenv,
  makeDesktopItem,
  fetchurl,
  makeWrapper,
  xorg,
}:
stdenv.mkDerivation rec {
  pname = "hdos";
  version = "8";

  jar = fetchurl {
    url = "https://cdn.hdos.dev/launcher/v${version}/hdos-launcher.jar";
    hash = "sha512-oyFuH5Pcpx8hp3NmTQYf9TTCOJXgGTdBF34IKD/ZsmN8X+8/tecxZGRkZOXurehY63oeX+dQHP4JgtmXsY9eYA==";
  };

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/flathub/dev.hdos.HDOS/master/dev.hdos.HDOS.png";
    hash = "sha512-qJlxF0YSzKvbHZVvCJP3Np23jRjMZhIyzGS9fypGYA4lUmfv0jfj3/BkRS3wTGlWnfo2TdPVj0Z6q3Zvooau5w==";
  };

  dontUnpack = true;

  desktop = makeDesktopItem {
    name = "HDOS";
    type = "Application";
    exec = "hdos";
    icon = icon;
    comment = "Open source Old School RuneScape client";
    desktopName = "HDOS";
    genericName = "HD Oldschool Runescape Client";
    categories = ["Game"];
  };

  nativeBuildInputs = [makeWrapper pkgs.openjdk11];
  installPhase = ''
    mkdir -p $out/share/hdos
    mkdir -p $out/share/applications

    ln -s ${jar} $out/share/hdos/hdos-launcher.jar
    ln -s ${desktop}/share/applications/HDOS.desktop $out/share/applications/HDOS.desktop

    makeWrapper ${pkgs.openjdk11}/bin/java $out/bin/hdos \
      --chdir "$out" \
      --prefix LD_LIBRARY_PATH : "${xorg.libXxf86vm}/lib" \
      --add-flags "-jar $out/share/hdos/hdos-launcher.jar"
  '';

  meta = with lib; {
    description = "Open source Old School RuneScape client";
    homepage = "https://hdos.dev/";
    sourceProvenance = with sourceTypes; [
      binaryBytecode
      binaryNativeCode
    ];
    license = licenses.bsd2;
    maintainers = with maintainers; [diegopyl1209];
    platforms = ["x86_64-linux"];
  };
}
