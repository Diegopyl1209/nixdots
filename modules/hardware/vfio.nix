{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.nixos.vfio.enable {
    boot = {
      kernelModules = ["vfio" "vfio-pci" "vfio_iommu_type1" "vfio_virqfd"];
      blacklistedKernelModules = ["nvidia" "nouveau"];
      kernelParams = ["amd_iommu=on" "iommu=pt"] ++ lib.optional config.nixos.vfio.acs "pcie_acs_override=downstream,multifunction";
      extraModprobeConfig = "options vfio-pci ids=(lib.concatStringsSep ',' config.nixos.vfio.gpuIDs)";
      # not neccesary in kernel zen
      /*
        kernelPatches = lib.mkIf config.nixos.vfio.acs [
        {
          name = "add-acs-overrides";
          patch = pkgs.fetchurl {
            name = "add-acs-overrides.patch";
            url = "https://aur.archlinux.org/cgit/aur.git/plain/add-acs-overrides.patch?h=linux-vfio&id=6f5c5ff2e42abf6606564383d5cb3c56b13d895e";
            sha256 = "1qd68s9r0ppynksbffqn2qbp1whqpbfp93dpccp9griwhx5srx6v";
          };
        }
      ];
      */
    };
  };
}
