{
  pkgs,
  config,
  ...
}:
with config.scheme.withHashtag; {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["custom/distro-icon" "hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["tray" "network" "clock" "custom/exit-button"];

        "hyprland/workspaces" = {
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "clock" = {
          interval = 60;
          tooltip = true;
          format = "{:%I:%M%p}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        "bluetooth" = {
          format = " {status}";
          format-connected = "";
          format-connected-battery = " {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        "custom/distro-icon" = {
          format = "";
        };

        "custom/exit-button" = {
          format = "";
        };

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };

        "network" = {
          format-ethernet = "󰈀";
        };
      };
    };

    style = ''
                     @define-color base00 ${base00}; @define-color base01 ${base01}; @define-color base02 ${base02}; @define-color base03 ${base03};
                     @define-color base04 ${base04}; @define-color base05 ${base05}; @define-color base06 ${base06}; @define-color base07 ${base07};
                     @define-color base08 ${base08}; @define-color base09 ${base09}; @define-color base0A ${base0A}; @define-color base0B ${base0B};
                     @define-color base0C ${base0C}; @define-color base0D ${base0D}; @define-color base0E ${base0E}; @define-color base0F ${base0F};

      window {
        background: @base00;
      }

      #custom-distro-icon {
        color: cyan;
        background: @base01;
        font-size: 25px;
        padding: 5px 15px;
        margin: 8px;
        border-radius: 5px;
      }

      #workspaces {
        background: @base01;
        font-size: 20px;
        padding:10px 15px;
        margin: 8px;
        border-radius: 3px;
      }

      #workspaces button {
          font-size: 0px;
          border-radius: 3px;
          background: @base06;
          min-width: 10px;
          min-height: 5px;
          margin: 4px 9px 4px 0px;
          padding: 0px 10px 0px 0px;
          transition-property: min-width;
          transition-duration: 0.1s;
        }


        #workspaces button.empty {
          border-radius: 3px;
          font-size: 0px;
          background: @base03;
          min-width: 1px;
          min-height: 5px;
          padding: 0px 10px 0px 0px;
         }
         
        #workspaces button.visible {
          border-radius: 3px;
          font-size: 0px;
          background: @base0A;
          min-width: 30px;
          min-height: 5px;
          padding: 0px 10px 0px 0px;
          transition-property: min-width;
          transition-duration: 0.1s;
        }


         #tray {
           background: @base01;
           margin: 8px;
           border-radius:5px;
           padding: 5px 10px;
         }

         #clock {
           font-size:20px;
           background: @base01;
           margin: 8px;
           border-radius:5px;
           padding: 5px 10px;
         }

        #custom-exit-button {
          font-size: 22px;
          background: @base01;
          padding: 5px 10px;
          margin: 8px 8px 8px 0px;
          border-radius: 5px;
       }

       #network {
         font-size: 22px;
         background: @base01;
         padding: 5px 10px;
         margin: 8px 0px;
         border-radius: 5px;
       }

    '';
  };
}
