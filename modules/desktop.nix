{ pkgs, ... }:

{
  programs.niri.enable = true;

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

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  qt.enable = true;
}
