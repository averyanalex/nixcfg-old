{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./physical.nix
    ./amdgpu.nix
    ./sdboot.nix
  ];

  # Storage
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "uas"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];

  # AMD
  boot.kernelModules = [ "kvm-amd" ];
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  # Screen
  boot.kernelParams = [
    "video=DP-1:3440x1440@144"
  ];
  boot.loader.systemd-boot.consoleMode = "max";
  hardware.video.hidpi.enable = true;
}
