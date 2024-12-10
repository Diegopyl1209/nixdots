{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.nixos.nvidia.drivers.enable {
    # Make sure opengl is enabled
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    boot = {
      # use nvidia framebuffer
      # https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers#Kernel_module_parameters for more info.
      kernelParams = ["nvidia-drm.fbdev=1"];
    };

    # Tell Xorg to use the nvidia driver (also valid for Wayland)
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      # Modesetting is needed for most Wayland compositors
      modesetting.enable = true;

      # Use the open source version of the kernel module
      # Only available on driver 515.43.04+
      open = false;

      package = config.boot.kernelPackages.nvidiaPackages.${config.nixos.nvidia.drivers.version}; #config.boot.kernelPackages.nvidiaPackages.beta;

      # Enable the nvidia settings menu
      nvidiaSettings = true;
    };

    /*
      environment.variables = lib.mkIf config.nixos.nvidia.hyprland.enable {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "0";
    };
    */
  };
}
