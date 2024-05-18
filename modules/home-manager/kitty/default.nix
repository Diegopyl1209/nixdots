{
  pkgs,
  config,
  inputs,
  ...
}: let
  substitute = name:
    pkgs.writeShellScriptBin name ''
      ${pkgs.kitty}/bin/kitty "$@"
    '';

  schemeFile = config.scheme {
    templateRepo = inputs.base16-kitty;
    target = "default-256";
  };
in {
  home = {
    packages = with pkgs; [kitty (substitute "xterm")];
    sessionVariables.TERMINAL = "xterm";
    sessionVariables.TERM = "xterm";
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = config.stylix.fonts.monospace.name; #"FiraCode Nerd Font Mono";
      copy_on_select = "clipboard";
      scrollback_lines = 10000;
      update_check_interval = 0;
      disable_ligatures = "never";
      confirm_os_window_close = 0;
      window_padding_width = 24;
      adjust_line_height = 0;
      adjust_column_width = 0;
      box_drawing_scale = "0.01, 0.8, 1.5, 2";
      mouse_hide_wait = 0;
      focus_follows_mouse = "no";
      hide_window_decorations = "yes";
      repaint_delay = 20;
      input_delay = 2;
      sync_to_monitor = "no";
      visual_bell_duration = 0;
      enable_audio_bell = false;
      bell_on_tab = "yes";
    };
    extraConfig = ''
      include ${schemeFile}
    '';
  };

  home.shellAliases = {
    ssh = "kitten ssh";
  };
}
