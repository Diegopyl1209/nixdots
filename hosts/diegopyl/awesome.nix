{ inputs, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager = {
        #defaultSession = "none+awesome";
        startx.enable = true;
      };
      windowManager.awesome = {
        enable = true;
      };
    };
  };

}
