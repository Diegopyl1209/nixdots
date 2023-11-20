{ 
lib
, cmake
, ninja
, fetchzip
, pkg-config
, pcre2
, util-linux
, libselinux
, libsepol
, pcre
, xorg
, pkgs
, fetchgit
, libarchive
, gtk3
, libcef
, stdenv
, fetchurl
, libXcomposite
, libXdamage
, libXext
, libXfixes
, libXrandr
, glib
, nss
, nspr
, atk
, at-spi2-atk
, libdrm
, expat
, libxcb
, libxkbcommon
, libX11
, mesa
, pango
, cairo
, alsa-lib
, dbus
, at-spi2-core
, cups
, libxshmfence
, steam-run
, makeWrapper}:

stdenv.mkDerivation rec {
  name = "bolt-launcher";
  version = "0.4.1";

  src = fetchgit{
    url = "https://github.com/Adamcake/Bolt.git";
    rev = "baaaa072d25ec188eca255436809f1c553ef850b";
    sha256 = "sha256-f7m9wkYVTUCajGtBsdbyHJ9WH0b/XjKnVa46onvRwms=";
  };
  
  cef-bin = fetchzip {
    url = "https://adamcake.com/cef/cef-114.0.5735.134-linux-x86_64-minimal-ungoogled.tar.gz";
    sha256 = "sha256-hc8PAGWom+iUljDQHs2pGoXUGmYcButcPBHjKpUh9vA=";
  };

  nativeBuildInputs = [ 
    cmake
    ninja
    pkg-config
    pcre2
    util-linux.dev
    libselinux
    libsepol
    pcre
    pkgs.libthai
    pkgs.libdatrie
    pkgs.libxkbcommon
    pkgs.libepoxy
    pkgs.libdrm
    pkgs.libxkbcommon
    pkgs.mesa
    pkgs.wget
    makeWrapper
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXdmcp
    xorg.libXtst
    libarchive
    gtk3
    
 ];

  
  rpath = lib.makeLibraryPath [
    glib
    nss
    nspr
    atk
    at-spi2-atk
    libdrm
    expat
    libxcb
    libcef
    libxkbcommon
    libX11
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    mesa
    gtk3
    alsa-lib
    dbus
    at-spi2-core
    libxshmfence
  ];
 
  
  configurePhase = ''
    substituteInPlace CMakeLists.txt --replace opt/bolt-launcher $out/opt/bolt-launcher

    mkdir -p share/applications
    mkdir cef/dist
    
    cp -r "${cef-bin}"/* cef/dist
    chmod +w -R cef/dist
    patchShebangs .
    patchelf --set-rpath "${rpath}" cef/dist/Release/libcef.so

    sed 's/-O0/-O2/' -i ./cef/dist/cmake/cef_variables.cmake
    
    cmake -S . -G Ninja -DCMAKE_BUILD_TYPE=Release
    
   
  '';
  
  installPhase = ''
    cmake --install . --prefix $out
  
    mkdir $out/share
    cp -r $out/usr/local/share/* $out/share
    rm -r $out/usr
    makeWrapper ${steam-run}/bin/steam-run $out/bin/bolt --add-flags "$out/opt/bolt-launcher/bolt"
  '';
  
  meta = with lib; {
    description = "An alternative launcher for your favourite MMO ";
    homepage = "https://github.com/Adamcake/Bolt/";
    maintainers = with maintainers; [ diegopyl1209 ];
    platforms = [ "x86_64-linux" ];
  };
  
}

