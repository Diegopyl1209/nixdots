{lib, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
    extraUpFlags = ["--login-server https://diegopyl.duckdns.org"];
  };
  networking.firewall.allowedUDPPorts = [41641]; # Facilitate firewall punching
}
