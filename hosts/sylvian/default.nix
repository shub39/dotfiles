{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "sylvian";

  my = {
    gaming.enable = false;
    devTools.enable = false;
    editor.enable = false;
    laptop.enable = false;
    homeserver.enable = false;
    hermes.enable = false;
    immich.enable = true;
    niri.enable = false;
    gnome.enable = true;
  };

  # Keep the config-editing toolchain for the admin user without pulling the
  # full editor package set into every account.
  users.users.shub39.packages = with pkgs; [
    zed-editor
    nil
    nixd
  ];

  users.users."russel" = {
    isNormalUser = true;
    description = "russel";
    extraGroups = [
      "networkmanager"
    ];
    # Intentionally passwordless.
    hashedPassword = "";
    packages = with pkgs; [
      localsend
      obs-studio
    ];
  };

  # Drawing apps: replace the shared flatpak desktop defaults.
  services.flatpak.packages = [
    "io.github.OpenToonz"
    "org.kde.krita"
  ];

  # Always-on machine: never suspend or hibernate.
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  programs.dconf.enable = true;
  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
        };
      };
    }
  ];

  services.printing.enable = true;
  programs.firefox.enable = true;

  # Immich data disk.
  fileSystems."/var/lib/immich" = {
    device = "/dev/disk/by-uuid/3212cf63-2292-4558-80b9-056bb2ef7456";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  system.stateVersion = "26.05";
}
