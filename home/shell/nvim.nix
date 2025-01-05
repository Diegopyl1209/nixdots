{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    #inputs.Lumi.packages.${system}.default
    commitizen
  ];
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "c";
          command = "git cz c";
          description = "Commit with commitzen";
          context = "files";
          loadingText = "Opening commitzen...";
          subprocess = true;
        }
      ];
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    clipboard.providers.wl-copy.enable = true;
    plugins = {
      lightline.enable = true;
      nix.enable = true;
      yazi.enable = true;
      vimtex.enable = true;
    };
  };
}
