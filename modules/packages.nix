{ pkgs, ... }:

{
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

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
