{ config, pkgs, ... }:

let
  editor = if config.my.editor.enable then "zeditor --wait" else "nvim";
  rebuild = if pkgs.stdenv.isDarwin then "darwin-rebuild" else "nixos-rebuild";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";

      plugins = [
        "git"
        "sudo"
        "docker"
      ];
    };

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.nix-ld.enable = true;

  environment.shellAliases = {
    # rebuild the current host from the dotfiles flake
    rs = "sudo ${rebuild} switch --flake ~/.config/dotfiles#${config.networking.hostName}";
  };

  environment.variables = {
    EDITOR = editor;
    VISUAL = editor;
  };
}
