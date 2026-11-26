{ ... }:
{
  nix.gc = {
    automatic = true;
    interval = {
      Hour = 3;
      Minute = 15;
    };
  };
}
