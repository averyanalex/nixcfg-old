{ pkgs, ... }:

{
  home-manager.users.alex = {
    home.packages = [ pkgs.polymc ];
  };

  services.syncthing.folders."PolyMC" = {
    id = "polymc";
    path = "/home/alex/.local/share/PolyMC";
    ignorePerms = false;
    devices = [ "hamster" "alligator" ];
  };

  persist.state.homeDirs = [ ".local/share/PolyMC" ];
}
