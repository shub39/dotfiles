{
  config,
  inputs,
  lib,
  ...
}:

{
  imports = [ inputs.hermes-agent.nixosModules.default ];

  config = lib.mkIf config.my.hermes.enable {
    services.hermes-agent = {
      enable = true;
      container.enable = true;
      container.backend = "docker";
      addToSystemPackages = true;
      container.hostUsers = [ "shub39" ];
      environmentFiles = [ "/var/lib/hermes/env" ];
      settings.webapp = {
        enabled = true;
        host = "0.0.0.0";
        port = 9120;
      };
    };

    security.sudo.extraRules = [
      {
        users = [ "shub39" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/docker";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
