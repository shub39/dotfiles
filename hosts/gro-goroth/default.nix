{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/features/laptop.nix
    ../../modules/features/homeserver.nix
  ];

  networking.hostName = "gro-goroth";

  my = {
    gaming.enable = false;
    devTools.enable = false;
  };

  system.stateVersion = "26.05";
}
