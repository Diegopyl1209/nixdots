{
  pkgs,
  config,
  ...
}: let
  aliases = {
    "db" = "distrobox";
    "fl" = " ~/.local/flutter/bin/flutter";
    "arch" = "distrobox-enter arch -- zsh";
    "fedora" = "distrobox-enter Fedora -- zsh";
    "eza" = "eza -l --sort type --no-permissions --no-user --no-time --header --icons --no-filesize --group-directories-first";
    "tree" = "eza --tree";
    "ls" = "exa";
    "ll" = "eza";
    "nv" = "nvim";
    "gs" = "git status";
    "gb" = "git branch";
    "gch" = "git checkout";
    "gc" = "git commit";
    "ga" = "git add";
    "gr" = "git reset --soft HEAD~1";
    "f" = ''fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'';
    "rm" = "gio trash";
  };
in {
  programs = {
    thefuck.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        autoload -Uz compinit && compinit
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':notify:*' check-focus no
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        path+=('/home/diegopyl/.local/bin')
        path+=('/home/diegopyl/.local/share/flutter/bin/')
        path+=('/home/diegopyl/.pub-cache/bin')

        AUTO_NOTIFY_THRESHOLD=600
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

        # pnpm
        export PNPM_HOME="/home/diegopyl/.local/share/pnpm"
        case ":$PATH:" in
           	*":$PNPM_HOME:"*) ;;
           	*) export PATH="$PNPM_HOME:$PATH" ;;
        esac
        # pnpm end
      '';
      shellAliases = aliases;
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
      ];
    };

    bash = {
      enable = true;
      shellAliases = aliases;
    };
  };
}
