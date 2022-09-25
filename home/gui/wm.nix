{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # screenshots
    grim
    slurp

    # clipboard
    wl-clipboard

    # icons
    gnome3.adwaita-icon-theme

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

    # file manager
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.tumbler # previews

    # volume control
    pulseaudio
  ];

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
