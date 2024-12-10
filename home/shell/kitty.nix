{config, ...}: {
  programs.kitty = {
    enable = config.home-manager.kitty.enable;
    settings = {
      font_family = "FiraCode Nerd Font Mono";
      scrollback_lines = 10000;
      update_check_interval = 0;
      confirm_os_window_close = 0;
      window_padding_width = 2;
      cursor_shape = "beam";
      cursor_beam_thickness = 9;
      copy_on_select = "clipboard";
      hide_window_decorations = "yes";
    };
  };
}
