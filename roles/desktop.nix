{ inputs, ... }: {
  imports = [
    ./base.nix
  ] ++ (with inputs.self.nixosModules.modules; [
    nebula-frsqr
    waydroid
  ]) ++ (with inputs.self.nixosModules.profiles;
    with apps; [
      d3.cura
      d3.freecad
      d3.openscad

      firefox
      office
      open
      telegram
      tex
      vscode
    ] ++ (with games; [
      minecraft
      xonotic
    ]) ++ [
      sway

      autologin
      flatpak
      music
      nebula-frsqr
      pipewire
      sync
      tank
      waydroid
      xanmod
    ]);
}
