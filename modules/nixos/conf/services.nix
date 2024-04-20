{pkgs, ...}: {
  services.dbus.enable = true;
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.postgresql = {
    enable = true;
    ensureDatabases = ["mydb"];
    enableTCPIP = true;
    # port = 5432;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  services = {
    displayManager.defaultSession = "gnome";
    xserver = {
      xkb = {
        layout = "latam";
        variant = "";
      };
    };
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
