{
  imports = [
    ./gpg
    ./zsh
    ./git.nix
    ./apps.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "alex";
    homeDirectory = "/home/alex";
    stateVersion = "22.05";
  };
}
