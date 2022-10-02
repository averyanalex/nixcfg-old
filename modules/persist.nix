{ lib, config, impermanence, ... }:

let
  inherit (builtins) concatMap;
  inherit (lib) mkIf;

  cfg = config.persist;

  takeAll = what: concatMap (x: x.${what});
  persists = with cfg; [ state derivative cache ];
  # absoluteHomeFiles = map (x: "${cfg.homeDir}/${x}");
  # allHomeFiles = takeAll "homeFiles" persists;
  absoluteEtcFiles = map (x: "/etc/${x}");
  allEtcFiles = absoluteEtcFiles (takeAll "etcFiles" persists);
  allDirectories = takeAll "directories" persists;
in
{
  imports = [
    impermanence.nixosModules.impermanence
  ];

  options =
    let
      inherit (lib) mkOption mkEnableOption;
      inherit (lib.types) listOf path str;

      common = {
        directories = mkOption {
          type = listOf path;
          default = [ ];
        };
        etcFiles = mkOption {
          type = listOf str;
          default = [ ];
        };
        homeFiles = mkOption {
          type = listOf str;
          default = [ ];
        };
      };

    in
    {
      persist = {
        enable = mkEnableOption "tmpfs root with opt-in state";

        persistRoot = mkOption {
          type = path;
          default = "/persist";
        };

        state = common;
        derivative = common;
        cache = common;
      };
    };

  config = mkIf cfg.enable {
    environment.persistence.${cfg.persistRoot} = {
      directories = allDirectories;
      files = allEtcFiles;
    };

    fileSystems."/" = {
      device = "none";
      options = [ "defaults" "size=4G" "mode=755" ];
      fsType = "tmpfs";
    };

    fileSystems."${cfg.persistRoot}" = {
      neededForBoot = true;
    };

    boot.initrd.postMountCommands = ''
      mkdir -p /mnt-root/nix
      mount --bind /mnt-root${cfg.persistRoot}/nix /mnt-root/nix
      chmod 755 /mnt-root
    '';
  };
}
