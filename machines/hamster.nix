{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/lenovo.nix
    ../mounts/hamster.nix
  ];

  networking = {
    hostName = "hamster";

    nebula-averyan.enable = true;
    nebula-frsqr.enable = true;

    networkmanager.enable = true;
  };
}
