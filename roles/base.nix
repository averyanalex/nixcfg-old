{ inputs, ... }: {
  imports = (with inputs.self.nixosModules; [
    nebula-averyan
    persist
  ]) ++ (with inputs.self.nixosProfiles; [
    gpg
    zsh
    direnv
    git
    micro
    utils
    zoxide

    agenix
    boot
    dns
    home
    locale
    misc
    nebula-averyan
    nix
    nur
    persist
    ssh-server
    unstable
    user
    userdirs
    xdg
  ]);
}
