{ ... }:
{
  imports = [
    ../../modules/nix.nix
    ../../modules/nix-darwin.nix
  ];

  system.stateVersion = 7;

  networking.hostName = "alll-mer"
}