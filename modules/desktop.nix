{ lib, config, pkgs, ... }:

{
  options = {
    isDesktop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Is this a desktop machine.";
    };
  };

  config = lib.mkIf config.isDesktop {
    services.getty.autologinUser = "alex";

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      gtkUsePortal = true;
    };

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };

    services.flatpak.enable = true;
    services.dbus.enable = true;
    services.gvfs.enable = true;
    programs.dconf.enable = true;

    users.users.alex.extraGroups = [ "video" "adbusers" ];
    programs.adb.enable = true;
    programs.light.enable = true;

    security.rtkit.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
