{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "gro-goroth";

  my = {
    gaming.enable = false;
    devTools.enable = false;
    laptop.enable = true;
    homeserver.enable = true;
    hermes.enable = true;
  };

  system.stateVersion = "26.05";
}
