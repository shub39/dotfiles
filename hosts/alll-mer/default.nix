{ pkgs, config, ... }:

# standalone for now, will distribute it later
{
  imports = [
    ../../modules/options.nix
    ../../modules/fonts.nix
    ../../modules/homebrew.nix
    ../../modules/nix.nix
    ../../modules/nix-darwin.nix
    ../../modules/packages-darwin.nix
    ../../modules/shell.nix
    ../../modules/shell-darwin.nix
  ];

  system.stateVersion = 7;

  networking.hostName = "alll-mer";

  system.primaryUser = "shub39";

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/Applications/Zen.app"
      "/Applications/Zed.app"
    ]; 
  };

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = [ "/Applications" ];
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
}
