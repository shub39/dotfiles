{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.my.homeserver.enable {
    services.jellyfin = {
      package = pkgs.unstable.jellyfin;
      enable = true;
      openFirewall = true;
      user = "shub39";
    };

    services.qbittorrent = {
      package = pkgs.unstable.qbittorrent-nox;
      enable = true;
      webuiPort = 6969;
      openFirewall = true;
      profileDir = "/mnt/media/qbittorrent";
      extraArgs = [ "--confirm-legal-notice" ];
    };

    services.slskd = {
      enable = true;
      package = pkgs.unstable.slskd;
      user = "shub39";
      group = "users";
      environmentFile = "/etc/slskd.env";
      openFirewall = true;
      domain = null;
      settings = {
        shares = {
          directories = [
            "/mnt/media/music"
          ];
        };
        directories = {
          downloads = "/mnt/media/temp/slskd/downloads";
          incomplete = "/mnt/media/temp/slskd/incomplete";
        };
        web = {
          port = 5030;
        };
      };
    };

    services.tailscale = {
      package = pkgs.unstable.tailscale;
      enable = true;
      useRoutingFeatures = "client";
    };

    fileSystems."/mnt/media" = {
      device = "/dev/disk/by-uuid/98bffd2c-423a-4377-8624-867ceb60dac2";
      fsType = "ext4";
      options = [ "nofail" ];
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    networking.firewall.allowedTCPPorts = [ 5030 ];

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
      "d /mnt/media/qbittorrent 0755 qbittorrent qbittorrent -"
    ];
  };
}
