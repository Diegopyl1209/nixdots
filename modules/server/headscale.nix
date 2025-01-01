{
  config,
  lib,
  ...
}: {
  options.server.headscale.enable = lib.mkEnableOption "Enable Headscale" // {default = config.server.enable;};
  config = lib.mkIf config.server.headscale.enable {
    networking.firewall = {
      allowedTCPPorts = [7000];
      allowedUDPPorts = [7000];
    };
    services.headscale = {
      enable = true;
      port = 7000;
      address = "0.0.0.0";
      settings = {
        #server_url = "http://192.168.1.17:7000";
        dns.magic_dns = true;
        dns.base_domain = "tailnet.localhost.com";
      };
    };
  };
}
