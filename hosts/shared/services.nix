{ pkgs, ... }:
{
   services.dbus.enable = true;
   services.printing.enable = true;
   hardware.bluetooth = {
     enable = true;
     powerOnBoot = false;
   };
   services.xserver = {
     layout = "latam";
     xkbVariant = "";
   };
   systemd.services.usbreset = {
    description = "fix my usb dongle";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.usb-reset}/bin/usb-reset 33fa:0001
    '';
  };
}
