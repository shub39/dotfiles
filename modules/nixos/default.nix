{
  imports = [
    ./environment.nix
    ../features/gaming.nix
    ../features/laptop.nix
    ../features/homeserver.nix
    ../features/hermes.nix
    ../features/immich.nix
    ../common/packages.nix
    ./packages.nix
  ];
}
