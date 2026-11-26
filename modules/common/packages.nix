{ config, lib, pkgs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  # duplicated in the two original files — the only true dedupe here
  both = with pkgs; [ neovim fastfetch git ];
  darwinExtra = with pkgs; [ mkalias nixd nil uv ];
  linuxDesktop = with pkgs; [
    quickshell
    kdePackages.qt5compat
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
    pwvucontrol
    easyeffects
    baobab
    mpv
    gnome-system-monitor
    chromium
    # look and feel
    nwg-look
    gruvbox-dark-gtk
    gruvbox-gtk-theme
    gruvbox-plus-icons
    ledfx
  ];
in
{
  environment.systemPackages =
    both
    ++ lib.optionals isDarwin darwinExtra
    ++ lib.optionals (!isDarwin) linuxDesktop
    ++ lib.optionals (!isDarwin && config.my.editor.enable) (with pkgs; [
      zed-editor
      nixd
      nil
      unstable.jetbrains-toolbox
    ])
    ++ lib.optionals (!isDarwin && config.my.devTools.enable) (with pkgs; [
      android-tools
      godot
      nixfmt
      uv
      unstable.audacity
    ]);
}
