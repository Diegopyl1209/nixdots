{
  config,
  lib,
  pkgs,
  ...
}: let
  nvidiaVulkanPath = lib.strings.concatStrings [config.boot.kernelPackages.nvidiaPackages.${config.nixos.nvidia.drivers.version} "/share/vulkan/icd.d/nvidia_icd.x86_64.json"];
in {
  options.nixos = {
    nvidia = {
      enable = lib.mkEnableOption "Nvidia drivers";
      prime = {
        enable = lib.mkEnableOption "NvidiaPrime";
        amdgpuBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
        nvidiaBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
        intelBusId = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
      };
      version = lib.mkOption {
        type = lib.types.enum ["latest" "stable" "production" "beta"];
        default = "latest";
      };
    };
  };

  config = lib.mkIf config.nixos.nvidia.enable {
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

      package = config.boot.kernelPackages.nvidiaPackages.${config.nixos.nvidia.version}; #config.boot.kernelPackages.nvidiaPackages.beta;

      # Enable the nvidia settings menu
      nvidiaSettings = true;
    };

    hardware.nvidia.prime = lib.mkIf config.nixos.nvidia.prime.enable {
      offload = {
        enable = true;
        enableOffloadCmd = false;
      };
      amdgpuBusId = config.nixos.nvidia.prime.amdgpuBusId;
      nvidiaBusId = config.nixos.nvidia.prime.nvidiaBusId;
      intelBusId = config.nixos.nvidia.prime.intelBusId;
    };

    environment.systemPackages = lib.mkIf config.nixos.nvidia.prime.enable [
      (pkgs.writeShellScriptBin
        "nvidia-offload"
        ''
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __VK_LAYER_NV_optimus=NVIDIA_only
          export VK_ICD_FILENAMES=${nvidiaVulkanPath}
          exec "$@"
        '')
    ];
  };
}
