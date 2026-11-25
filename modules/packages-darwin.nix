{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    fastfetch
    vicinae
    nixd
    nil
    uv
    git
  ];
}