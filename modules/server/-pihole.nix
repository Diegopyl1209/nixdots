{...}: let
  serverIP = "127.0.0.1";
  dataDir = "/run/media/hdd1/Server/Data/PiHole";
in {
  networking.firewall.allowedTCPPorts = [
    # Pi-Hole
    3080
    30443
    # DNS
    53
  ];
  networking.firewall.allowedUDPPorts = [
    # DNS
    53
  ];
  virtualisation.oci-containers.containers.pihole = {
    image = "pihole/pihole:latest";
    /*
       extraOptions = [
      "--network=host"
    ];
    */
    ports = [
      "${serverIP}:53:53/tcp"
      "${serverIP}:53:53/udp"
      "3080:80"
      "30443:443"
    ];
    volumes = [
      "${dataDir}/var/lib/pihole/:/etc/pihole/"
      "${dataDir}/var/lib/dnsmasq.d:/etc/dnsmasq.d/"
    ];
    environment = {
      ServerIP = serverIP;
      TZ = "America/Santiago";
    };
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--dns=127.0.0.1"
      "--dns=1.1.1.1"
    ];
    workdir = "${dataDir}/var/lib/pihole/";
  };
}
