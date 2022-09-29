{ pkgs, config, ... }:

{
  imports = [
    ../modules
    ../hardware/whale-vm.nix
    ../mounts/seal.nix
  ];

  services.nfs.server = {
    enable = true;
    exports = ''
      /tank 10.5.3.101(rw,sync,wdelay,no_root_squash)
    '';
  };

  networking = {
    hostName = "seal";

    firewall.interfaces."nebula.averyan" = {
      allowedTCPPorts = [ 111 2049 ];
      allowedUDPPorts = [ 111 2049 ];
    };

    nebula-averyan.enable = true;
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
