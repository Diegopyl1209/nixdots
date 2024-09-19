{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

  config = lib.mkIf config.hm.home-manager.battery.enable {
    # Better scheduling for CPU cycles
    services.system76-scheduler.settings.cfsProfiles.enable = true;

    # Auto cpu frequency
    programs.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };

        battery = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };

    # Disable GNOMEs power management
    services.power-profiles-daemon.enable = false;

    # Enable powertop
    powerManagement.powertop.enable = lib.mkForce true;

    # Enable thermald (only necessary if on Intel CPUs)
    services.thermald.enable = true;
  };
}
