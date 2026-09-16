{ pkgs, user, ... }:
let
  services = "/home/${user.name}/services";
  diskMappings = [
    # "/dev/disk/by-uuid/36631632-ad35-4330-b92c-c598ba72fb8a:/mnt/external1"
  ];
in
{
  networking.firewall.interfaces."podman+".allowedTCPPortRanges = [
    { from = 0; to = 65535; }
  ];
  
  virtualisation = {
    podman = {
      enable = true;
    };
    oci-containers.containers = {
      homer = {
        image = "ghcr.io/bastienwirtz/homer:latest";
        ports = ["80:8080"];
        volumes = ["${services}/homer:/www/assets"];
      };
      calibre = {
        image = "ghcr.io/crocodilestick/calibre-web-automated:latest";
        ports = ["8083:8083"];
        volumes = ["${services}/calibre:/config"] ++ diskMappings;
      };
      jellyfin = {
        image = "ghcr.io/linuxserver/jellyfin:latest";
        ports = ["8096:8096"];
        devices = ["/dev/dri/card0:/dev/dri/card0"];
        volumes = ["${services}/jellyfin:/config"] ++ diskMappings;
        environment = {
          PUID = "${toString user.uid}";
          PGID = "100";
        };
      };
      sonarr = {
        image = "ghcr.io/linuxserver/sonarr:latest";
        ports = ["8989:8989"];
        volumes = ["${services}/sonarr:/config"] ++ diskMappings;
      };
      lidarr = {
        image = "ghcr.io/linuxserver/lidarr:latest";
        ports = ["8686:8686"];
        volumes = ["${services}/lidarr:/config"] ++ diskMappings;
      };
      radarr = {
        image = "ghcr.io/linuxserver/radarr:latest";
        ports = ["7878:7878"];
        volumes = ["${services}/radarr:/config"] ++ diskMappings;
      };
      prowlarr = {
        image = "ghcr.io/linuxserver/prowlarr:latest";
        ports = ["9696:9696"];
        volumes = ["${services}/prowlarr:/config"];
      };
      bazarr = {
        image = "ghcr.io/linuxserver/bazarr:latest";
        ports = ["6767:6767"];
        volumes = ["${services}/bazarr:/config"] ++ diskMappings;
      };
      qbittorrent = {
        image = "ghcr.io/hotio/qbittorrent";
        ports = ["8080:8080"];
        volumes = ["${services}/qbittorrent:/config"] ++ diskMappings;
        environment = {
          VPN_ENABLED = "true";
          VPN_CONF = "wg0";
          VPN_PROVIDER = "generic";
          VPN_LAN_NETWORK = "192.168.1.0/24";
          VPN_NAMESERVERS = "8.8.8.8";
        };
      };
    };
  };
}
