{ lib, ... }:

{
  options.my = {
    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Steam and gaming support.";
    };

    devTools.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable general development tools (Android tools, Godot, formatters, uv).";
    };

    editor.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the Zed editor and the Nix language servers (nixd, nil).";
    };
  };
}
