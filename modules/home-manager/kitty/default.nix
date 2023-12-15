{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  substitute = name:
    pkgs.writeShellScriptBin name ''
      ${pkgs.kitty}/bin/kitty "$@"
    '';

  mkTuple = lib.hm.gvariant.mkTuple;
  schemeFile = config.scheme {
    templateRepo = inputs.base16-kitty;
    target = "default-256";
  };
in {
  home = {
    packages = with pkgs; [kitty (substitute "xterm")]; #kgx = gnome-console
    sessionVariables.TERMINAL = "xterm";
    sessionVariables.TERM = "xterm";
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka Nerd Font Mono";
      italic_font = "auto";
      bold_font = "auto";
      bold_italic_font = "auto";
      font_size = 12;
      disable_ligatures = "never";
      confirm_os_window_close = 0;
      window_padding_width = 24;
      adjust_line_height = 0;
      adjust_column_width = 0;
      box_drawing_scale = "0.01, 0.8, 1.5, 2";
      mouse_hide_wait = 0;
      focus_follows_mouse = "no";

      # Performance
      repaint_delay = 20;
      input_delay = 2;
      sync_to_monitor = "no";

      # Bell
      visual_bell_duration = 0;
      enable_audio_bell = "no";
      bell_on_tab = "yes";
    };
    extraConfig = ''
      include ${schemeFile}

      font_family FiraCode Nerd Font Mono
      modify_font cell_height 120%
      click_interval 0.5
      cursor_blink_interval 0
      modify_font cell_width 87%

    '';
  };
}
