{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.my.immich.enable {
    services.immich = {
      package = pkgs.unstable.immich;
      enable = true;
      host = "0.0.0.0";
      port = 2283;
      openFirewall = true;
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/immich 0700 immich immich -"
    ];
  };
}
