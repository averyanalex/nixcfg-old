{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # sway
    # wl-clipboard # clipboard support
    # TODO: change clipboard manager (CopyQ?)
    # clipman # clipboard manager
    # rofi-wayland # apps menu
    # TODO: setup dunst
    # mako # notifications
    gnome3.adwaita-icon-theme # icons
    pulseaudio # volume control

    # keyring
    gnome.seahorse
    gnome.gnome-keyring
    gcr

    # fonts
    dejavu_fonts
    freefont_ttf
    gyre-fonts # TrueType substitutes for standard PostScript fonts
    liberation_ttf
    unifont
    noto-fonts-emoji
    noto-fonts-cjk
    meslo-lgs-nf
    # (nerdfonts.override { fonts = [ "Meslo" ]; })

    xfce.thunar # file manager
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.tumbler # previews
  ];

  programs.bash.enable = true;
  # programs.bash.profileExtra = ''
  #   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  #     sway
  #   fi
  # '';

  fonts.fontconfig.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "MesloLGS NF";
    };
  };

  services.gpg-agent.pinentryFlavor = "qt"; # TODO: fix gnome3 pinentry

  services.gnome-keyring.enable = true;
}
