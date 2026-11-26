{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "Shubham Gorai";
        email = "cptnshubham39@gmail.com";
        signingkey = "~/.ssh/id_ed25519.pub";
      };

      commit.gpgsign = true;
      gpg.format = "ssh";
    };
  };
}
