{ ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "shub39";
  };

  services.qbittorrent = {
    enable = true;
    webuiPort = 6969;
    openFirewall = true;
    serverConfig = {
      LegalNotice.Accepted = true;
      BitTorrent.Session.DefaultSavePath = "/mnt/media/temp";
    };
  };

  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/98bffd2c-423a-4377-8624-867ceb60dac2";
    fsType = "ext4";
    options = [
      "nofail"
    ];
  };

  
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # Download directories on the media partition.
  systemd.tmpfiles.rules = [
    "d /mnt/media/temp 0755 qbittorrent qbittorrent -"
  ];
}
