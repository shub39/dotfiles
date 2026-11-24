{ ... }:
{
  nix.gc = {
    automatic = true;
    dates = "daily";
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/shub39/.config/dotfiles";
    upgrade = false;
    dates = "weekly";
  };

  # NixOS-only: lets dynamically linked, non-Nix binaries run.
  programs.nix-ld.enable = true;
}
