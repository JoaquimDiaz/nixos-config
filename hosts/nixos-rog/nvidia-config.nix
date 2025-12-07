{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Removing 'nouveau' driver following freezes/crashes on the ROG
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;

  # NVIDIA
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    open = false;
    prime = {
      offload.enable = true;
      amdgpuBusId = "PCI:6:0:0"; # AMD Radeon 680M (iGPU)
      nvidiaBusId = "PCI:1:0:0"; # NVIDIA RTX 3060 (dGPU)
    };
  };

}
