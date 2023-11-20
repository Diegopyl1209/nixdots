{ pkgs, ... }:
{
   services.dbus.enable = true;
   services.flatpak.enable = true;
   services.printing.enable = true;
   hardware.bluetooth = {
     enable = true;
     powerOnBoot = false;
   };
   services.xserver = {
     layout = "latam";
     xkbVariant = "";
     displayManager.defaultSession = "hyprland";
   };
   systemd.services.usbreset = {
    description = "fix my usb dongle";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    restartIfChanged = false;
    script = ''
      ${pkgs.usb-reset}/bin/usb-reset 33fa:0001
    '';
  };
  
    security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  
    services.blueman = {
    enable = true;
  };
}
