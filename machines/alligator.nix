{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/alligator.nix
    ../mounts/alligator.nix
  ];

  networking = {
    hostName = "alligator";

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
