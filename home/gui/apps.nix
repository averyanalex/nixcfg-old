{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # communication
    unstable.tdesktop
    unstable.element-desktop

    # files
    gnome.nautilus # file manager
    evince # documents
    mpv # video
    gthumb # images
    kate # text
    libsForQt5.ark # archives
    f3d # 3d

    # games
    polymc

    # etc
    virt-manager
    freecad
  ];
}
