{ pkgs, ... }:

{
  # tmpfs /tmp
  boot = {
    cleanTmpDir = true;
    tmpOnTmpfs = true;
  };

  # TRIM
  services.fstrim.enable = true;

  # ZSH completions
  environment.pathsToLink = [ "/share/zsh" ];

  # Why not? Also for agenix
  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  # Time
  time.timeZone = "Europe/Moscow";

  # English language
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  system = {
    stateVersion = "22.05";
    # autoUpgrade = {
    #   enable = true;
    #   allowReboot = false;
    #   flake = "git+https://git.frsqr.xyz/firesquare/nixos.git?ref=main";
    #   dates = "4:45";
    # };
  };

  networking.useDHCP = false;

  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@users" ];
      trusted-users = [ "@wheel" ];
    };

    daemonCPUSchedPolicy = "batch";
    daemonIOSchedPriority = 5;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # Needed for git flakes
  environment.systemPackages = [ pkgs.git ];
}
