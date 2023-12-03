let
  email = "diegopyl1209@gmail.com";
  name = "DiegoPYL1209";
in {
  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      url = {
        "ssh://git@github.com/" = {
          insteadOf = [
            "https://github.com/"
          ];
        };
      };
      url = {
        "ssh://git@gist.github.com/" = {
          insteadOf = [
            "https://gist.github.com/"
          ];
        };
      };
      url = {
        "ssh://git@gitlab.com/" = {
          insteadOf = [
            "https://gitlab.com/"
          ];
        };
      };
      color.ui = true;
      core.editor = "nvim";
      github.user = name;
      github.signingkey = "~/.ssh/id_rsa.pub";
    };
    userEmail = email;
    userName = name;
  };
}
