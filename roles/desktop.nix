{ inputs, ... }: {
  imports = [
    ./base.nix
  ] ++ (with inputs.self.nixosModules; [
    nebula-frsqr
  ]) ++ (with inputs.self.nixosProfiles; [
    firefox
    polymc
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
