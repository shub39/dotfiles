{ inputs, ... }:

{
  imports = [ inputs.hermes-agent.nixosModules.default ];

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    environmentFiles = [ "/var/lib/hermes/env" ];
    container = {
      enable = true;
      hostUsers = [ "shub39" ];
    };
    settings = {
      model.default = "deepseek/deepseek-v4.1-flash-1017";
      toolsets = [ "all" ];
      terminal = { backend = "local"; timeout = 180; };
      display = { compact = false; personality = "teacher"; };
      memory = { memory_enabled = true; user_profile_enabled = true; };
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "shub39";
  };

  services.qbittorrent = {
    enable = true;
    webuiPort = 6969;
    openFirewall = true;
    profileDir = "/mnt/media/qbittorrent";
    extraArgs = [ "--confirm-legal-notice" ];
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  security.sudo.extraRules = [
    {
      users = [ "your-username" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/docker";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

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
    "d /mnt/media/qbittorrent 0755 qbittorrent qbittorrent -"
  ];
}
