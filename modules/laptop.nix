{ ... }:

{
  # ThinkPad firmware and CPU microcode (also gates the microcode update
  # referenced in hardware-configuration.nix).
  hardware.enableRedistributableFirmware = true;

  # Laptop power management.
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.thermald.enable = true;
  zramSwap.enable = true;

  # Bluetooth.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
