{ config, inputs, ... }:

{
  imports = [
    inputs.self.nixosRoles.desktop
    inputs.self.nixosProfiles.openrgb
    ./hardware.nix
    ./mounts.nix
  ];

  networking = {
    firewall.enable = false;

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
