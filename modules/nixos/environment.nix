# Base system configuration shared by every NixOS host: boot, networking,
# locale, audio, desktop plumbing, users, shell and git. Application packages
# live in the platform aggregator (default.nix) so minimal hosts can opt out.
{
  imports = [
    ../common
    ./boot.nix
    ./audio.nix
    ./desktop.nix
    ./flatpak.nix
    ./networking.nix
    ./ssh.nix
    ./users.nix
    ./locale.nix
    ./nix.nix
    ./shell.nix
    ./git.nix
  ];
}
