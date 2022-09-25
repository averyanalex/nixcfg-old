{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    htop
    killall
    smartmontools
    ncdu
    micro
  ];
}
