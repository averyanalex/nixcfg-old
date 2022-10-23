{ inputs, ... }: {
  imports = [
    ./base.nix
  ] ++ (with inputs.self.nixosModules; [
    nebula-frsqr
  ]) ++ (with inputs.self.nixosProfiles; [
    firefox
    freecad
    polymc
    telegram
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
