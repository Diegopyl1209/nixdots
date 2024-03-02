{pkgs, ...}: {
  services.dbus.enable = true;
  services.flatpak.enable = true;
  services.printing.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  services.xserver = {
    xkb = {
      layout = "latam";
      variant = "";
    };
    displayManager.defaultSession = "gnome";
  };
  systemd.services.usbreset = {
    description = "fix my usb dongle";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    restartIfChanged = false;
    script = ''
      ${pkgs.usb-reset}/bin/usb-reset 33fa:0001
    '';
  };

  services.blueman = {
    enable = true;
  };
}
