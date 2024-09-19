{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.home-manager.graphical.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "nemo.desktop";

        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/vnd.rar" = "org.gnome.FileRoller.desktop";
        "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
        "application/pdf" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/plain" = "org.gnome.TextEditor.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      };
    };
    xdg.configFile."mimeapps.list".force = true;
  };
}
