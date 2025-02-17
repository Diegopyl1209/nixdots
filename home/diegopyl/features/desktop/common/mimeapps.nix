{
  config,
  lib,
  ...
}: {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    xdg.mimeApps = {
      enable = true; #config.home-manager.graphical.enable;
      defaultApplications = {
        "text/plain" = "Helix.desktop";
        "application/x-shellscript" = "Helix.desktop";
        "text/x-cmake" = "Helix.desktop";
        "text/markdown" = "Helix.desktop";
        "application/x-docbook+xml" = "Helix.desktop";
        "application/json" = "Helix.desktop";
        "application/x-yaml" = "Helix.desktop";
        "text/rhtml" = "Helix.desktop";
        "text/x-tex" = "Helix.desktop";
        "text/x-java" = "Helix.desktop";
        "inode/x-empty" = "Helix.desktop";
        "text/x-python" = "Helix.desktop";
        "text/x-readme" = "Helix.desktop";
        "text/x-markdown" = "Helix.desktop";

        "inode/directory" = "org.gnome.nautilus.desktop";

        "text/html" = "firefox.desktop";
        "x-scheme-handler/ftp" = "userapp-Zen-8ZLC22.desktop";
        "application/xhtml+xml" = "userapp-Zen-8ZLC22.desktop";
        "x-scheme-handler/http" = "userapp-Zen-8ZLC22.desktop";
        "x-scheme-handler/https" = "userapp-Zen-8ZLC22.desktop";
        "x-scheme-handler/chrome" = "userapp-Zen-8ZLC22.desktop";
        "application/x-extension-htm" = "userapp-Zen-8ZLC22.desktop";
        "application/x-extension-xht" = "userapp-Zen-8ZLC22.desktop";
        "application/x-extension-html" = "userapp-Zen-8ZLC22.desktop";
        "application/x-extension-shtml" = "userapp-Zen-8ZLC22.desktop";
        "application/x-extension-xhtml" = "userapp-Zen-8ZLC22.desktop";
        "x-scheme-handler/about" = "userapp-Zen-8ZLC22.desktop";
        "x-scheme-handler/unknown" = "userapp-Zen-8ZLC22.desktop";
      };
    };
    xdg.configFile."mimeapps.list".force = true;
}
