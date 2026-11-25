{ ... }:

{
  nix-homebrew = {
    enable = true;
    user = "shub39";
    autoMigrate = true;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    brews = [
      "libimobiledevice"
      "node"
      "openjdk@21"
      "pnpm"
      "portaudio"
      "xcodegen"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    casks = [
      "bluesnooze"
      "utm"
      "qeude/tap/defi"
    ];
  };
}