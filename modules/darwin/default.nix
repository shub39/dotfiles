{
  imports = [
    ../common
    ./homebrew.nix
    ./nix.nix
    ./shell.nix
    ./packages.nix
    # TODO(phase 6): ./defaults.nix once moved out of the host file
  ];
}
