{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/whale.nix
    ../mounts/whale.nix
  ];

  networking = {
    hostName = "whale";

    vlans = {
      wan = {
        id = 30;
        interface = "enp6s0";
      };
    };

    bridges = {
      lan = {
        interfaces = [ "enp5s0" ];
      };
    };

    interfaces = {
      lan = {
        ipv4 = {
          addresses = [{
            address = "192.168.3.1";
            prefixLength = 24;
          }];
        };
      };
      wan.useDHCP = true;
    };
  };
}
