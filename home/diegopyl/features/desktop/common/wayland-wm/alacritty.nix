{config, ...}: {
  # Set as default terminal
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations_theme_variant = "Dark";
        padding = {
          x = 24;
          y = 26;
        };
      };
    };
  };
}
