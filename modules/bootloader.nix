# bootloader.nix
{ ... }:
{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = false;
    # Windows EFI saved from OSProb
    extraEntries = ''
      menuentry 'Windows Boot Manager (on /dev/nvme1n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-A6C5-D3A2' {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root A6C5-D3A2
          chainloader /efi/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };

  boot.loader.efi.efiSysMountPoint = "/boot";
}
