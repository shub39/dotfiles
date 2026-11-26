{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "rher";

  system.stateVersion = "26.05";
}
