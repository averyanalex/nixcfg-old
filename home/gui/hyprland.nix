{ pkgs, ... }:

let
  fancylock = pkgs.writeShellScript "fancylock" ''
    swaylock \
    	--screenshots \
    	--clock \
    	--indicator \
    	--indicator-radius 100 \
    	--indicator-thickness 7 \
    	--effect-blur 9x15 \
    	--effect-vignette 0.5:0.5 \
    	--ring-color bb00cc \
    	--key-hl-color 880033 \
    	--line-color 00000000 \
    	--inside-color 00000088 \
    	--separator-color 00000000 \
    	--fade-in 1.5 \
      "$@"
  '';
  idlehandler = pkgs.writeShellScript "idlehandler" ''
    swayidle -w timeout 300 '${fancylock} --grace 60'
  '';
in
{
  imports = [
    ./wm.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp
    swayidle
    swaylock-effects
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    recommendedEnvironment = true;
    extraConfig = ''
      monitor=,preferred,auto,1

      general {
        border_size=2

        gaps_in=5
        gaps_out=10

        col.active_border=0x66ee1111
        col.inactive_border=0x66333333
      }

      decoration {
        rounding=7

        blur=1
        blur_size=3
        blur_passes=1
        blur_new_optimizations=1
      }

      input {
        kb_layout=us,ru
        kb_options=grp:alt_shift_toggle

        numlock_by_default=1

        touchpad {
          disable_while_typing=0
          natural_scroll=yes
          # clickfinger_behavior=1
        }
      }

      gestures {
          workspace_swipe=1
      }

      dwindle {
        pseudotile=1
        bind=SUPER,V,togglesplit,
      }

      bind=SUPER,Q,killactive,
      bind=SUPER,F,fullscreen,0
      bind=SUPERSHIFT,E,exit,
      bind=SUPER,return,exec,alacritty
      bind=SUPER,space,togglefloating,
      bind=SUPER,D,exec,rofi -show drun
      bind=SUPER,L,exec,${fancylock} --grace 3

      bind=,xf86monbrightnessup,exec,light -A 10
      bind=,xf86monbrightnessdown,exec,light -U 10
      bind=,xf86audioraisevolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
      bind=,xf86audiolowervolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
      bind=,xf86audiomute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle
      bind=,xf86audiomicmute,exec,exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

      bind=,print,exec,grim -g "$(slurp -d)" - | tee ~/Pictures/Screenshots/$(date +%H_%M_%S-%d_%m_%Y).png | wl-copy -t image/png
      bind=SHIFT,print,exec,grim - | tee ~/Pictures/Screenshots/$(date +%H_%M_%S-%d_%m_%Y).png | wl-copy -t image/png

      bind=SUPER,left,movefocus,l
      bind=SUPER,right,movefocus,r
      bind=SUPER,up,movefocus,u
      bind=SUPER,down,movefocus,d

      bind=SUPERSHIFT,left,movewindow,l
      bind=SUPERSHIFT,right,movewindow,r
      bind=SUPERSHIFT,up,movewindow,u
      bind=SUPERSHIFT,down,movewindow,d

      bind=SUPER,1,workspace,1
      bind=SUPER,2,workspace,2
      bind=SUPER,3,workspace,3
      bind=SUPER,4,workspace,4
      bind=SUPER,5,workspace,5
      bind=SUPER,6,workspace,6
      bind=SUPER,7,workspace,7
      bind=SUPER,8,workspace,8
      bind=SUPER,9,workspace,9
      bind=SUPER,0,workspace,10

      bind=SUPERSHIFT,1,movetoworkspacesilent,1
      bind=SUPERSHIFT,2,movetoworkspacesilent,2
      bind=SUPERSHIFT,3,movetoworkspacesilent,3
      bind=SUPERSHIFT,4,movetoworkspacesilent,4
      bind=SUPERSHIFT,5,movetoworkspacesilent,5
      bind=SUPERSHIFT,6,movetoworkspacesilent,6
      bind=SUPERSHIFT,7,movetoworkspacesilent,7
      bind=SUPERSHIFT,8,movetoworkspacesilent,8
      bind=SUPERSHIFT,9,movetoworkspacesilent,9
      bind=SUPERSHIFT,0,movetoworkspacesilent,10

      exec-once=waybar
      exec-once=${idlehandler}
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    '';
  };

  programs.bash.enable = true;
  programs.bash.profileExtra = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      Hyprland
    fi
  '';

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [ pkgs.rofi-emoji ];
    terminal = "alacritty";
    extraConfig = {
      modi = "drun,run,emoji,ssh";
      show-icons = true;
    };
  };

  programs.waybar = {
    enable = true;
    # package = pkgs.unstable.waybar.overrideAttrs (old: {
    #   version = "710f895";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "Alexays";
    #     repo = "Waybar";
    #     rev = "710f895";
    #     sha256 = "sha256-kHkFRQwFPen4QbMdXODr8o+Ms0Ee3OGzqTTDjvel4xA=";
    #   };
    #   nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.unstable.cmake ];
    #   buildInputs = old.buildInputs ++ [ pkgs.unstable.jack2 ];
    #   mesonFlags = old.mesonFlags ++ [
    #     "-Dexperimental=true"
    #   ];
    #   postPatch = ''
    #     sed -i '1 i\#define HAVE_HYPRLAND' include/factory.hpp;
    #     sed -i '1 i\#define HAVE_WLR' include/factory.hpp;
    #   '';
    # });
    settings = [{
      modules-left = [
        "tray"
        "mpd"
      ];
      modules-center = [
        "cpu"
        "memory"
        "disk"
      ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "upower"
        "network"
        "clock"
      ];
      # cpu = {
      #   format = "{icon} {usage}%";
      # };
    }];
    # style = ''
    #   window#waybar {
    #     background: #20262d;
    #     color: #f1fcf9;
    #   }

    #   #memory {
    #     background: #343b41;
    #     padding: 5px;
    #     margin: 3px;
    #     margin-top: 5px;
    #     margin-bottom: 5px;
    #     border-radius: 7px;
    #   }

    #   #cpu {
    #     background: #343b41;
    #     padding: 5px;
    #     margin: 3px;
    #     margin-top: 5px;
    #     margin-bottom: 5px;
    #     border-radius: 7px;
    #   }

    #   #disk {
    #     background: #343b41;
    #     padding: 5px;
    #     margin: 3px;
    #     margin-top: 5px;
    #     margin-bottom: 5px;
    #     border-radius: 7px;
    #   }
    # '';
  };
}
