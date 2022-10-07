{ inputs, ... }: {
  imports = [
    ./base.nix
  ] ++ (with inputs.self.nixosModules; [
  ]) ++ (with inputs.self.nixosProfiles; [
    firefox
    polymc
    vscode

    sway

    autologin
    flatpak
    pipewire
    sync
    tank
  ]);
}
