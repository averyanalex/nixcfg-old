{ lib, config, home-manager, hyprland, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.alex = lib.mkMerge [
    hyprland.homeManagerModules.default
    (import ../home)
    (lib.mkIf config.isDesktop (import ../home/gui))
  ];
}
