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
    rs = "sudo ${rebuild} switch --flake ~/.config/dotfiles#${config.networking.hostName}";
    ff = "fastfetch --config ~/.config/dotfiles/fastfetch/config.jsonc";
    e = "cd ~/.config/dotfiles";
  };

  environment.variables = {
    EDITOR = editor;
    VISUAL = editor;
  };
}
