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

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  
  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/98bffd2c-423a-4377-8624-867ceb60dac2";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # This machine doubles as the home server, so keep it running: closing the
  # lid does nothing and suspend/hibernate are disabled entirely.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
    IdleAction = "ignore";
  };

  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
    AllowSuspendThenHibernate = "no";
    AllowHybridSleep = "no";
  };

  systemd.tmpfiles.rules = [
    "d /mnt/media/temp 0755 qbittorrent qbittorrent -"
  ];
}
