{ inputs, ... }: {
  imports = [
    ./base.nix
  ] ++ (with inputs.self.nixosModules; [
  ]) ++ (with inputs.self.nixosProfiles; [
    firefox
    vscode

    sway

    flatpak
    pipewire
    tank
  ]);
}
