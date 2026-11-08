{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "rher";

  system.stateVersion = "26.05";
}
