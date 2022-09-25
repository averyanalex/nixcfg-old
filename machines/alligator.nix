{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/alligator.nix
    ../mounts/alligator.nix
  ];

  isDesktop = true;

  home-manager.users.alex = {
    wayland.windowManager.sway.config.output.DP-1.mode = "3440x1440@144Hz";
  };

  networking = {
    hostName = "alligator";

    nebula-averyan.enable = true;
    nebula-frsqr.enable = true;

    defaultGateway = {
      address = "192.168.3.1";
      interface = "enp10s0";
    };

    interfaces.enp10s0 = {
      ipv4 = {
        addresses = [{
          address = "192.168.3.60";
          prefixLength = 24;
        }];
      };
    };
  };
}
