{ ... }:

{
  # referenced in hardware-configuration.nix).
  hardware.enableRedistributableFirmware = true;

  # Laptop power management.
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.thermald.enable = true;
  zramSwap.enable = true;

  # Cap charging at 80% to extend battery life. ThinkPad firmware exposes the
  # limit via charge_control_end_threshold; the udev rule re-applies it on
  # boot, resume and battery re-detection.
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="power_supply", KERNEL=="BAT*", TEST=="charge_control_end_threshold", ATTR{charge_control_end_threshold}="80"
  '';

  # Bluetooth.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
