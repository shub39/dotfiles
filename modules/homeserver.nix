{ inputs, pkgs, ... }:

{
  imports = [ inputs.hermes-agent.nixosModules.default ];

  services.hermes-agent = {
    enable = true;
    container.enable = true;
    container.backend = "docker";
    addToSystemPackages = true;
    container.hostUsers = [ "shub39" ];
    environmentFiles = [ "/var/lib/hermes/env" ];
    settings.webapp = {
      enabled = true;
      host = "0.0.0.0";
      port = 9120;
    };
  };

  security.sudo.extraRules = [
    {
      users = [ "shub39" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/docker";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  services.jellyfin = {
    package = pkgs.unstable.jellyfin ;
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

  services.immich = {
    package = pkgs.unstable.immich;
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;
    mediaLocation = "/mnt/media/immich";
    user = "shub39";
    group = "users";
    accelerationDevices = [ "/dev/dri/renderD128" ];
    settings.ffmpeg = {
      accel = "vaapi";
      accelDecode = true;
    };
  };

  # VA-API driver for the Intel iGPU, used by immich's ffmpeg.
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];

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
    "d /mnt/media/qbittorrent 0755 qbittorrent qbittorrent -"
  ];
}
