{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/environment.nix
    ../../modules/features/immich.nix
  ];

  networking.hostName = "sylvian";

  my = {
    editor.enable = false;
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

  # Keep en_IN: the Immich PostgreSQL data directory was initialised with this
  # locale. Changing it drops en_IN from i18n.supportedLocales and the database
  # fails to start.
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

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

  # Minimal package set: the shared desktop packages are intentionally not
  # imported for this host. `fastfetch` backs the shared `ff` shell alias.
  environment.systemPackages = with pkgs; [
    neovim
    fastfetch
  ];

  system.stateVersion = "26.05";
}
