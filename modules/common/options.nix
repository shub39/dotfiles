{ lib, ... }:

let
  opt = default: description: {
    enable = lib.mkOption {
      type = lib.types.bool;
      inherit default description;
    };
  };
in
{
  options.my = {
    gaming = opt true "Steam and gaming support.";
    devTools = opt true "General development tools (Android tools, Godot, formatters, uv).";
    editor = opt true "Zed editor and the Nix language servers (nixd, nil).";
    laptop = opt false "Laptop power management and ThinkPad charge cap.";
    homeserver = opt false "Home server services (jellyfin, qbittorrent, slskd, tailscale).";
    hermes = opt false "Hermes agent container (docker) with its web UI.";
    immich = opt false "Immich photo server. Mount its data disk at /var/lib/immich on the host.";
    niri = opt true "Niri compositor with the ly display manager.";
    gnome = opt false "GNOME desktop environment with GDM.";
  };
}
