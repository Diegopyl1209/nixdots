{
  lib,
  config,
  default,
  pkgs,
  ...
}: let
  swayosd-server = "${pkgs.swayosd}/bin/swayosd-server";
  swayosd-client = "${pkgs.swayosd}/bin/swayosd-client";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in {
  wayland.windowManager.hyprland = {
    enable = config.home-manager.hyprland.enable;
    systemd.enable = false;

    settings = {
      exec-once = [
        "uwsm app -- ${swayosd-server}"
      ];
      env =
        [
        ]
        ++ lib.optionals (config.home-manager.hyprland.nvidia) [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "NVD_BACKEND,direct"
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];

      monitor = [
        ",preferred,auto,1"
      ];

      cursor = {
        no_hardware_cursors = config.home-manager.hyprland.nvidia;
      };

      general = {
        layout = "dwindle";
        resize_on_border = true;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        mouse_move_enables_dpms = false;
      };

      input = {
        kb_layout = "latam";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
          disable_while_typing = true;
          drag_lock = true;
        };
        sensitivity = 0.3;
        accel_profile = "flat";
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        force_split = 2;
      };

      decoration = {
        shadow = {
          enabled = true;
          color = "0x00000044";
        };
      };

      animations = {
        bezier = [
          "windowBezier, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 7, windowBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      bindle = [
        ",XF86MonBrightnessUp,   exec, ${swayosd-client} --brightness lower"
        ",XF86MonBrightnessDown, exec, ${swayosd-client} --brightness raise"
        ",XF86AudioRaiseVolume,  exec, ${swayosd-client} --output-volume raise"
        ",XF86AudioLowerVolume,  exec, ${swayosd-client} --output-volume lower"
        ",XF86AudioMute,         exec, ${swayosd-client} --output-volume mute-toggle"
      ];

      bindl = [
        ",switch:Lid Switch, exec, hyprlock" #
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvactive = binding "SUPER ALT" "moveactive";
        mvwindow = binding "SUPER SHIFT" "movewindow";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        arr = [1 2 3 4 5 6 7];
      in
        [
          "SUPER, Return, exec, uwsm app -- kitty"
          "SUPER, W, exec, uwsm app -- firefox"
          "SUPER, D, exec, uwsm app -- ${pkgs.hyprlauncher}/bin/hyprlauncher"

          "ALT, Tab, focuscurrentorlast"
          "CTRL ALT, Delete, exit"
          "ALT, Q, killactive"
          "SUPER, F, togglefloating"
          "SUPER, G, fullscreen"
          "SUPER, P, togglesplit"
          "SUPER, L, exec, hyprlock"

          (mvfocus "left" "l")
          (mvfocus "right" "r")
          (mvfocus "up" "u")
          (mvfocus "down" "d")
          (mvwindow "left" "l")
          (mvwindow "right" "r")
          (mvwindow "up" "u")
          (mvwindow "down" "d")
          (resizeactive "up" "0 -20")
          (resizeactive "down" "0 20")
          (resizeactive "right" "20 0")
          (resizeactive "left" "-20 0")
          (mvactive "up" "0 -20")
          (mvactive "down" "0 20")
          (mvactive "right" "20 0")
          (mvactive "left" "-20 0")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];
    };
  };
}
