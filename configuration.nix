{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;

  networking.hostName = "rher";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

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

  programs.niri.enable = true;
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "Shubham Gorai";
        email = "cptnshubham39@gmail.com";
        signingkey = "/home/shub39/.ssh/id_ed25519.pub";
      };

      commit.gpgsign = true;
      gpg.format = "ssh";
    };
  };
  services.displayManager.ly = {
    enable = true;
    settings = {
      animate = true;
      animation = "doom";
    };
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  environment.variables = {
    EDITOR = "zeditor --wait";
    VISUAL = "zeditor --wait";
  };

  environment.systemPackages = with pkgs; [
    # necessities
    quickshell
    kdePackages.qt5compat
    neovim
    fastfetch
    vicinae
    alacritty
    copyq
    nemo
    nemo-fileroller
    file-roller
    obs-studio
    networkmanager
    wl-clipboard
    brightnessctl
    wlsunset
    hyprpicker
    playerctl
    uv
    xwayland-satellite
    zed-editor
    nixfmt
    git
    pwvucontrol
    easyeffects
    baobab

    # dev tools
    android-tools
    godot
    nixd
    nil

    # look and feel
    nwg-look
    gruvbox-dark-gtk
    gruvbox-gtk-theme
    gruvbox-plus-icons

  ];

  qt.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";

      plugins = [
        "git"
        "sudo"
        "docker"
      ];
    };

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.nix-ld.enable = true;

  programs.steam.enable = true;

  services.openssh = {
    enable = true;
  };

  users.users.root.shell = pkgs.zsh;
  users.users."shub39" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "67";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}
