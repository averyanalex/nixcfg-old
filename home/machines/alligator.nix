{
  imports = [
    ../common.nix
    ../gui
  ];

  wayland.windowManager.sway.config.output."DP-1".mode = "3440x1440@144Hz";
}
