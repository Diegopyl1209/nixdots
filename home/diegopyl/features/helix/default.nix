{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables.EDITOR = "hx";
  home.sessionVariables.COLORTERM = "truecolor";

  programs.helix = {
    enable = true;
    settings = {
      editor = {
        color-modes = true;
        line-number = "relative";
        bufferline = "multiple";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          language-servers = ["nixd" "nil"];
        }
      ];
      language-server.nixd = {
        command = "nixd";
        config.formatting.command = "alejandra";
      };
    };
  };
  xdg.configFile."helix/config.toml".onChange = ''
    ${pkgs.procps}/bin/pkill -u $USER -USR1 hx || true
  '';
}
