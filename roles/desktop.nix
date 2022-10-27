{ inputs, ... }: {
  imports = [
    ./base.nix
  ] ++ (with inputs.self.nixosModules; [
    nebula-frsqr
  ]) ++ (with inputs.self.nixosProfiles; [
    cura
    firefox
    freecad
    minecraft
    openscad
    telegram
    tex
    vscode

    sway

    autologin
    flatpak
    nebula-frsqr
    pipewire
    sync
    tank
  ]);
}
