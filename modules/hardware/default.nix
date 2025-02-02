{...}: {
  imports = [
    ./battery.nix
    ./backlight.nix
    ./nvidia.nix
    ./amdgpu.nix
    ./vfio.nix
  ];
}
