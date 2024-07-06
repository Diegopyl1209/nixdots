{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      dconf
      catppuccin-gtk
      tree
      # gnome.dconf-editor
    ];
  };

  gtk = {
    enable = true;
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
