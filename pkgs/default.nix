{
  pkgs,
  username,
  ...
}: {
  imports = [
    #./autobrr/service.nix
    ./qbittorrent/service.nix
  ];

  users.users.${username}.packages = with pkgs; [
    # (pkgs.callPackage ./soundux.nix {})
  ];

  environment.systemPackages = [
  ];
}
