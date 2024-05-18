{pkgs, ...}: {
  services = {
    dbus.enable = true;
    flatpak.enable = true;
    printing.enable = true;
    blueman.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

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

  systemd.services.usbreset = {
    description = "fix my usb dongle";
    restartIfChanged = false;
    serviceConfig = {
      ExecStart = "${pkgs.usb-reset}/bin/usb-reset 33fa:0001";
      Type = "oneshot";
      RemainAfterExit = true;
    };

    wantedBy = ["multi-user.target"];
  };
}
