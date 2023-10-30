{ pkgs, inputs, ... }:
let
  my-python-packages = ps: with ps; [
    numpy
  ];

in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.java = { 
    enable = true;
    package = pkgs.openjdk17;
  };
  
  home.packages = with pkgs; [
    lutris
    heroic
    protonup-qt
    cartridges
    micro
    
    # gui
    spotify
    d-spy
    github-desktop
    transmission_4-gtk
    android-studio
    jetbrains-toolbox


    # tools
    bat
    eza
    dconf
    ranger
    fd
    ripgrep
    fzf
    socat
    jq
    acpi
    ffmpeg
    stow
    glib
    
   # langs
    nodejs
    bun
    typescript
    meson
    ninja
    (python3.withPackages my-python-packages)
    
  ];


}
