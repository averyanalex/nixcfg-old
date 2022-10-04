{ config, inputs, ... }:

{
  imports = [
    inputs.self.nixosRoles.desktop
    ./hardware.nix
    ./mounts.nix
  ];

  networking = {
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
