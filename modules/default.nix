{ agenix, home-manager, ... }:

{
  imports = [
    agenix.nixosModule
    home-manager.nixosModule
    # ./gui

    ./common.nix
    ./users.nix
    ./ssh.nix
    ./unstable.nix
    ./nur.nix
    ./dns.nix

    ./nebula-averyan.nix
    ./nebula-frsqr.nix
  ];
}
