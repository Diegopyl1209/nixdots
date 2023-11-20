{pkgs, ...}:
{
  fonts.packages = with pkgs; [
    material-design-icons
    phospor
    inter
    dosis
    material-symbols
    rubik
    ibm-plex
    (nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" ]; })
  ];

}
