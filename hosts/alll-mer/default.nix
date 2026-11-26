{ pkgs, config, ... }:

{
  imports = [
    ../../modules/darwin
  ];

  system.stateVersion = 7;

  networking.hostName = "alll-mer";

  time.timeZone = "Asia/Kolkata";

  system.primaryUser = "shub39";

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
      "/Applications/Zen.app"
      "/Applications/Zed.app"
    ];
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.GuestEnabled = false;
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;
    };
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
