{ self, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia-config.nix
      "${self}/modules/bootloader.nix"
      "${self}/modules/common.nix"
      "${self}/modules/window-manager.nix"
      "${self}/modules/network.nix"
      "${self}/modules/docker.nix"
      "${self}/modules/vm-windows.nix"
      "${self}/modules/slock.nix"
      "${self}/modules/autorandr.nix"
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}

