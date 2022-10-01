{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/alligator.nix
    ../mounts/alligator.nix
  ];

  isDesktop = true;
  services.syncthing.enable = true;

  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.docker-compose_2 ];

  home-manager.users.alex = {
    wayland.windowManager.sway.config.output.DP-1.mode = "3440x1440@144Hz";
  };

  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    config = {
      Peers = [
        "tls://eagle.frsqr.xyz:8362"
      ];
      IfName = "ygg0";
    };
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];

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
