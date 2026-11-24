{ ... }:
{
  imports = [
    ../../modules/nix.nix
    ../../modules/nix-darwin.nix
    ../../modules/shell.nix
  ];

  system.stateVersion = 7;

  networking.hostName = "alll-mer";
  nixpkgs.hostPlatform = "aarch64-darwin";
}