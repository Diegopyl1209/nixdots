{
  inputs,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      exec-once = [
        "swaync"
        "ags -b hypr"
        ''hyprctl dispatch exec "sleep 10s && discord --enable-features=UseOzonePlatform --ozone-platform=wayland" ''
        ''swaybg -i "${config.stylix.image}" ''
        "copyq --start-server"
        ''wl-paste -t text -w sh -c 'v=$(cat); cmp -s <(xclip -selection clipboard -o)  <<< "$v" || xclip -selection clipboard <<< "$v"' ''
      ];

      monitor = [
        ",preferred,auto,1"
      ];

      general = {
        layout = "dwindle";
        resize_on_border = false;
      };

      misc = {
        layers_hog_keyboard_focus = false;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

      input = {
        kb_layout = "latam";
        kb_model = "";
        follow_mouse = 1;
        sensitivity = 0;
        float_switch_override_focus = 2;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        # no_gaps_when_only = "yes";
      };

      windowrule = let
        f = regex: "float, ^(${regex})$";
      in [
        (f "org.gnome.Calculator")
        (f "kitty")
        (f "discord")
        (f "Armcord")
        (f "nemo")
        (f "pavucontrol")
        (f "nm-connection-editor")
        (f "blueberry.py")
        (f "Color Picker")
        (f "xdg-desktop-portal")
        (f "xdg-desktop-portal-gnome")
        (f "transmission-gtk")
        "workspace 9, title:Spotify"
      ];

      windowrulev2 = [
        "workspace special:chat silent, class:^(discord)$"
        "workspace special:chat silent, class:^(ArmCord)$"
        "stayfocused, title:^()$, class:^(steam)$"
        "minsize 1 1, title:^()$, class:^(steam)$"
      ];

      bind = [
        "SUPER, Return, exec, kitty"
        "SUPER SHIFT, Q, killactive"
        "SUPER SHIFT, Space, togglefloating"
        "SUPER, F, fullscreen"
        "SUPER, Y, pin"
        "SUPER, P, pseudo"
        "SUPER, J, togglesplit"
        "SUPER, C, togglespecialworkspace, chat"
        "SUPER SHIFT, S, movetoworkspace, special"
        "SUPER, S, togglespecialworkspace"

        "SUPER, D, exec, rofi -show drun"
        ", PRINT, exec, wayshot --stdout | wl-copy"
        ''SUPER SHIFT, PRINT, exec, wayshot -s "$(slurp)" --stdout | wl-copy''

        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 0"

        "SUPER SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER SHIFT, 9, movetoworkspacesilent, 9"
        "SUPER SHIFT, 0, movetoworkspacesilent, 0"
      ];

      bindle = let
        e = "exec, ags -b hypr -r";
      in [
        ",XF86AudioRaiseVolume, ${e} 'audio.speaker.volume += 0.05; indicator.speaker()'"
        ",XF86AudioLowerVolume, ${e} 'audio.speaker.volume -= 0.05; indicator.speaker()'"
      ];

      bindl = let
        e = "exec, ags -b hypr -r";
      in [
        ",XF86AudioPlay, ${e} 'mpris?.playPause()'"
        ",XF86AudioPrev, ${e} 'mpris?.previous()'"
        ",XF86AudioNext, ${e} 'mpris?.next()'"
        ",XF86AudioMicMute, ${e} 'audio.microphone.isMuted = !audio.microphone.isMuted'"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      decoration = {
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "md3_decel, 0.05, 0.7, 0.1, 1";
        animation = [
          "windows, 1, 2, md3_decel, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 2, default"
          "workspaces, 1, 3, default"
        ];
      };
    };
  };
}
