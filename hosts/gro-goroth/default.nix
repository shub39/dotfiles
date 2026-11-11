{ config, pkgs, ... }:

{
  imports =
    [ 
      ../../modules
      ./hardware-configuration.nix
    ];

  networking.hostName = "gro-goroth"; 

  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;

  system.stateVersion = "26.05";
}
