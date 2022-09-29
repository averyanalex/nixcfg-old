{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/whale-vm.nix
    ../mounts/seal.nix
  ];


  networking = {
    hostName = "seal";

    # nebula-averyan.enable = true;
    # nebula-frsqr.enable = true;

    defaultGateway = {
      address = "192.168.3.1";
      interface = "enp1s0";
    };

    interfaces.enp1s0 = {
      ipv4 = {
        addresses = [{
          address = "192.168.3.10";
          prefixLength = 24;
        }];
      };
    };
  };
}
