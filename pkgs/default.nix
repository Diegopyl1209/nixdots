{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./autobrr/service.nix
  ];

  users.users.${username}.packages = with pkgs; [
    #(pkgs.callPackage ./autobrr/package.nix {})
  ];
  environment.systemPackages = [
  ];
}
