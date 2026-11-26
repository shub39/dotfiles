{
  imports = [
    ../common
    ./homebrew.nix
    ./nix.nix
    ./shell.nix
    ../common/packages.nix
    # TODO(phase 6): ./defaults.nix once moved out of the host file
  ];
}
