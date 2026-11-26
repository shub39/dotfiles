{ pkgs, ... }:
{
  programs.zsh = {
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    # Let oh-my-zsh own the prompt instead of the default `prompt suse`.
    promptInit = "";

    # nix-darwin has no `ohMyZsh` module, so set it up manually.
    interactiveShellInit = ''
      export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
      plugins=(git sudo docker)
      ZSH_THEME="robbyrussell"
      ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh"
      [[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"
      source "$ZSH/oh-my-zsh.sh"
    '';
  };
}
