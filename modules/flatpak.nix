{
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "org.kde.kdenlive"
      "org.localsend.localsend_app"
      "org.torproject.torbrowser-launcher"
      "io.github.flattool.Warehouse"
      "app.zen_browser.zen"
    ];
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
  };
}
