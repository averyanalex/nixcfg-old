{ agenix, home-manager, ... }:

{
  imports = [
    agenix.nixosModule
    home-manager.nixosModule

    ./common.nix
    ./schedulers.nix
    ./network.nix
    ./users.nix
    ./home.nix
    ./desktop.nix
    ./ssh.nix
    ./unstable.nix
    ./nur.nix
    ./dns.nix
    ./syncthing.nix
    ./unfree.nix
    ./monitoring.nix
    ./persist.nix

    ./nebula-averyan.nix
    ./nebula-frsqr.nix
  ];
}
