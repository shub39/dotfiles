{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkMerge [
    {
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      security.polkit.enable = true;
      services.gnome.gnome-keyring.enable = true;
      qt.enable = true;
    }

    (lib.mkIf config.my.niri.enable {
      programs.niri.enable = true;

      services.displayManager.ly = {
        enable = true;
        settings = {
          animate = true;
          animation = "doom";
        };
      };

      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdg.portal.config.common.default = "gtk";
    })

    (lib.mkIf config.my.gnome.enable {
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
    })
  ];
}
