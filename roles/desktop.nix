{ inputs, ... }: {
  imports = [
    ./base.nix
  ] ++ (with inputs.self.nixosModules; [
    nebula-frsqr
  ]) ++ (with inputs.self.nixosProfiles; [
    cura
    firefox
    freecad
    open
    minecraft
    openscad
    telegram
    tex
    vscode

    sway

    autologin
    flatpak
    music
    nebula-frsqr
    pipewire
    sync
    tank
  ]);
}
