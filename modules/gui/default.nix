{ lib, config, pkgs, ... }:

{
  options = {
    machine.gui = lib.mkEnableOption {
      description = "Whether to enable GUI.";
    };
  };

  # imports = lib.mkIf config.machine.gui [
  #   ./pipewire.nix
  # ];

  config = lib.mkIf config.machine.gui {
    services.getty.autologinUser = "alex";

    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      gtkUsePortal = true;
    };

    services.flatpak.enable = true;

    programs.dconf.enable = true;

    users.users.alex.extraGroups = [ "video" "adbusers" ];
    programs.light.enable = true;

    services.gvfs.enable = true;

    programs.adb.enable = true;
  };
}
