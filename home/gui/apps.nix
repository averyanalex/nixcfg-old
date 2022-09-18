{ pkgs, ... }:

{
  home.packages = with pkgs; [
    virt-manager
    unstable.tdesktop
    unstable.element-desktop
  ];
}
