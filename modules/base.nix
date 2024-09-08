{
  lib,
  host,
  pkgs,
  config,
  inputs,
  system,
  username,
  ...
}: {
  # User
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "networkmanager" "adbusers"];
    shell = pkgs.zsh;
  };
  users.groups.media = {
    gid = 1800;
    members = [
      username
    ];
  };

  boot.plymouth.enable = true;

  # Bootloader.
  boot.loader.grub = {
    enable = lib.mkForce true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    efiInstallAsRemovable = true;
    gfxmodeEfi = "1920x1080";
    # theme = inputs.catppuccin-grub + "/src/catppuccin-mocha-grub-theme";
  };

  boot.loader.efi = {
    #canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  # boot.kernel.sysctl = {
  #   "vm.max_map_count" = 1048576;
  # };

  # Fix USB sticks not mounting or being listed:
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Bash shebang
  services.envfs.enable = true;

  services.tailscale.enable = true;
  # Hardware
  hardware.graphics.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  zramSwap = {
    enable = true;
  };

  # Adb
  programs.adb.enable = true;

  # Networking
  networking = {
    hostName = "${host}";
    networkmanager = {
      enable = true;
      settings.connectivity = {
        uri = "http://network-test.debian.org/nm";
        interval = 300;
      };
    };
    firewall.enable = false;
  };
  services.blueman.enable = config.hm.home-manager.bluetooth.enable;
  systemd.services.NetworkManager-wait-online.enable = false;
  # XDG Desktop Portal stuff
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    config.common.default = "*";
  };

  # X server
  services.xserver = {
    enable = config.hm.home-manager.graphical.enable;
    excludePackages = with pkgs; [xterm];
  };

  # Printing support
  services.printing = {
    enable = true;
    drivers = [pkgs.epson-escpr];
  };

  # Flatpak
  services.flatpak.enable = true;

  # Sound
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true; # (optional)
  };
  programs.noisetorch.enable = true;

  # Locate
  services.locate = {
    enable = true;
  };

  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  # Locale
  time.timeZone = "America/Santiago";

  # Internationalisation
  i18n.defaultLocale = "es_MX.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CL.UTF-8";
    LC_IDENTIFICATION = "es_CL.UTF-8";
    LC_MEASUREMENT = "es_CL.UTF-8";
    LC_MONETARY = "es_CL.UTF-8";
    LC_NAME = "es_CL.UTF-8";
    LC_NUMERIC = "es_CL.UTF-8";
    LC_PAPER = "es_CL.UTF-8";
    LC_TELEPHONE = "es_CL.UTF-8";
    LC_TIME = "es_CL.UTF-8";
  };

  # Env packages
  environment.systemPackages = with pkgs; [
    nh
    virt-manager
    gnome-disk-utility
    gutenprint
    git
    curl
    wget
    jq
    polkit
    polkit_gnome
    nil
  ];

  environment.sessionVariables = {
    FLAKE = "/home/${username}/nixos-config";
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "DroidSansMono"];})
    font-awesome
    manrope
    inter
    lexend
    material-design-icons
    meslo-lg
    meslo-lgs-nf
  ];

  # Virtualization
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };
  nix.optimise = {
    automatic = true;
    dates = ["10:00"];
  };

  # Enable needed programs
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh.enable = true;
  };
  # Nixos docs
  documentation = {
    nixos.enable = false;
    info.enable = false;
    man.enable = false;
  };
  # System stateversion
  system.stateVersion = "23.05";
}
