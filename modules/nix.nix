{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = prev.stdenv.hostPlatform.system;
        config = prev.config;
      };
    })
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/shub39/.config/dotfiles";
    upgrade = false; 
    dates = "weekly";
  };

  nixpkgs.config.allowUnfree = true;
}
