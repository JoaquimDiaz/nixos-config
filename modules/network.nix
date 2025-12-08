# network.nix
{ pkgs, ... }:
{
  # Networking / wifi control
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  boot.extraModprobeConfig = ''
    options mt7921e disable_aspm=Y
  '';

  environment.systemPackages = with pkgs; [
    # TUI for bluetooth
    bluetui
  ];
}
