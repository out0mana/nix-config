{ ... }:
{
  services.homer = {
    enable = true;
    virtualHost = {
      nginx.enable = true;
      domain = "localhost";
    };
    settings = {
      header = false;
      footer = false;
      services = [
        {
          name = "Services";
          icon = "fas fa-cloud";
          items = [
            {
              name = "Jellyfin";
              subtitle = "Media Server";
              url = "javascript:void(window.open(`//\${location.hostname}:8096`))";
            }
            {
              name = "Navidrome";
              subtitle = "Music Server";
              url = "javascript:void(window.open(`//\${location.hostname}:4533`))";
            }
            {
              name = "Calibre";
              subtitle = "Book Server";
              url = "javascript:void(window.open(`//\${location.hostname}:8083`))";
            }
            {
              name = "qBittorrent";
              subtitle = "Torrents";
              url = "javascript:void(window.open(`//\${location.hostname}:8080`))";
            }
          ];
        }
        {
          name = "Arrs";
          icon = "fas fa-skull-crossbones";
          items = [
            {
              name = "Sonarr";
              subtitle = "TV";
              url = "javascript:void(window.open(`//\${location.hostname}:8989`))";
            }
            {
              name = "Radarr";
              subtitle = "Movies";
              url = "javascript:void(window.open(`//\${location.hostname}:7171`))";
            }
            {
              name = "Prowlarr";
              subtitle = "Indexer";
              url = "javascript:void(window.open(`//\${location.hostname}:9696`))";
            }
            {
              name = "Bazarr";
              subtitle = "Subtitles";
              url = "javascript:void(window.open(`//\${location.hostname}:6767`))";
            }
          ];
        }
        {
          name = "Network";
          icon = "fas fa-network-wired";
          items = [
            {
              name = "Router";
              subtitle = "Router Admin";
              url = "http://192.168.1.1";
              target = "_blank";
            }
          ];
        }
      ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 ];
}
