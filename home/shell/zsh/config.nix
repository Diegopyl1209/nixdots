{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-notify";
        src = pkgs.fetchFromGitHub {
          owner = "marzocchi";
          repo = "zsh-notify";
          rev = "9c1dac81a48ec85d742ebf236172b4d92aab2f3f";
          sha256 = "sha256-ovmnl+V1B7J/yav0ep4qVqlZOD3Ex8sfrkC92dXPLFI=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    shellAliases = {
      ls = "eza --icons";
      cat = "bat";
      v = "nvim";
      vim = "nvim";
    };

    history = {
      path = "${config.xdg.dataHome}/.histfile";
      size = 10000;
      save = 10000;
    };

    initExtra = ''

      # Bind keys & opt

      setopt autocd
      unsetopt beep
      bindkey -e
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # Eval thefuck
      eval $(thefuck --alias)

      # Source starship
      source <(starship init zsh --print-full-init)

      # Direnv
      eval "$(direnv hook zsh)"
    '';
  };
}
