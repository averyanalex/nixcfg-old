{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/lenovo.nix
    ../mounts/hamster.nix
  ];

  isDesktop = true;

  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.docker-compose_2 ];

  services.blueman.enable = true;

  networking = {
    hostName = "hamster";

    nebula-averyan.enable = true;
    nebula-frsqr.enable = true;

    networkmanager.enable = true;
  };
}
