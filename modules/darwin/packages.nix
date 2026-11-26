{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    fastfetch
    nixd
    nil
    uv
    git
  ];
}