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

  environment.variables = {
    EDITOR = "zeditor --wait";
    VISUAL = "zeditor --wait";
  };
}
