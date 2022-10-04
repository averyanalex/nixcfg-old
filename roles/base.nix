{ inputs, ... }: {
  imports = (with inputs.self.nixosModules; [
    persist
  ]) ++ (with inputs.self.nixosProfiles; [
    gpg
    zsh
    git
    micro

    agenix
    boot
    dns
    home
    misc
    nur
    persist
    ssh-server
    unstable
    user
  ]);
}
