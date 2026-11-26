{ ... }:
{
  programs.zsh = {
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
}
