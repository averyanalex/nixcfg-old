{ config, pkgs, lib, ... }:

{
  # Autostart zsh in interactive non-tty sessions
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    if [[ "$(tty)" != /dev/tty* && $(ps --no-header --pid=$PPID --format=comm) != "zsh" && -z $BASH_EXECUTION_STRING ]]; then
      exec zsh
    fi
  '';

  # Beautiful cat
  programs.bat.enable = true;

  # Smart cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Fuzzy search
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Beautiful ls
  programs.exa = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;

    shellAliases = {
      ls = "${pkgs.exa}/bin/exa --icons -l";
      la = "${pkgs.exa}/bin/exa --icons -la";
      lt = "${pkgs.exa}/bin/exa --icons --tree";

      ip = "ip --color=auto";

      cd = "z";

      # nixupd = ''sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:averyanalex/nixos"'';
      tnixupd = "sudo nixos-rebuild switch --flake .";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "zsh-interactive-cd"
        "git-auto-fetch"
        "git"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}
