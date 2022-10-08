{ inputs, pkgs, ... }:

let
  polymc = inputs.polymc.packages.x86_64-linux.polymc.overrideAttrs (final: prev: {
    buildInputs = prev.buildInputs ++ [ pkgs.unstable.mangohud ];
  });
in
{
  home-manager.users.alex = {
    home.packages = [ polymc ];
  };

  services.syncthing.folders."PolyMC" = {
    id = "polymc";
    path = "/home/alex/.local/share/PolyMC";
    ignorePerms = false;
    devices = [ "hamster" "alligator" ];
  };

  persist.state.homeDirs = [ ".local/share/PolyMC" ];
}
