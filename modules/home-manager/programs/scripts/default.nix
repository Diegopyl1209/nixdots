 {config, ...}: {
  home = {
    file = {
      ".local/bin/ms" = {
        executable = true;
        text = import ./misc/ms.nix {};
      };
      ".local/bin/panes" = {
        executable = true;
        text = import ./eyecandy/panes.nix {};
        };
    };
  };
}
