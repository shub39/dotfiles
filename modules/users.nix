{ pkgs, ... }:

{
  users.users.root.shell = pkgs.zsh;

  users.users."shub39" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "67";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
