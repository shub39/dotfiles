{ config, lib, pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
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
      xwayland-satellite
      git
      pwvucontrol
      easyeffects
      baobab
      mpv

      # look and feel
      nwg-look
      gruvbox-dark-gtk
      gruvbox-gtk-theme
      gruvbox-plus-icons
      ledfx
    ]
    ++ lib.optionals config.my.editor.enable (with pkgs; [
      zed-editor
      nixd
      nil
      unstable.jetbrains-toolbox
    ])
    ++ lib.optionals config.my.devTools.enable (with pkgs; [
      android-tools
      godot
      nixfmt
      uv
    ]);

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
