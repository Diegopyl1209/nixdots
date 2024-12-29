{
  lib,
  config,
  ...
}: {
  options.nixos = {
    vfio = {
      enable = lib.mkEnableOption "Configure machine for VFIO";
      acs = lib.mkEnableOption "Use acs patch";
      gpuIDs = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "GPU Bus Ids";
      };
    };
    amdgpu = {
      enable = lib.mkEnableOption "AMD gpu";
    };
    nvidia = {
      drivers = {
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

    drives = lib.mkOption {
      type = with lib.types;
        listOf (
          submodule {
            options = {
              label = lib.mkOption {
                type = str;
                description = "Drive label";
              };
              mountpoint = lib.mkOption {
                type = str;
                description = "Drive mountpoint";
              };
              fstype = lib.mkOption {
                type = str;
                description = "Drive filesystem type";
              };
            };
          }
        );
      default = [];
      description = "Optional drives";
    };
  };
}
