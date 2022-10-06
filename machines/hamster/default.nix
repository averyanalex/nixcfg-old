{ config, inputs, ... }:

{
  imports = [
    inputs.self.nixosRoles.desktop
    inputs.self.nixosProfiles.netman
    ./hardware.nix
    ./mounts.nix
  ];
}
