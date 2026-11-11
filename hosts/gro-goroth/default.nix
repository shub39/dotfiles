{ ... }:

{
  imports = [
    ../../modules
    ../../modules/laptop.nix
    ../../modules/homeserver.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "gro-goroth";

  my = {
    gaming.enable = false;
    devTools.enable = false;
  };

  system.stateVersion = "26.05";
}
