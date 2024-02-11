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
      color.ui = true;
      core.editor = "nvim";
      github.user = name;
      github.signingkey = "~/.ssh/id_rsa.pub";
    };
    userEmail = email;
    userName = name;
  };
}
