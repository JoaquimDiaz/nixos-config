{ self, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      "${self}/modules/common.nix"
      "${self}/modules/window-manager.nix"
      "${self}/modules/network.nix"
      "${self}/modules/docker.nix"
      "${self}/modules/vm-windows.nix"
      "${self}/modules/slock.nix"
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}

