{pkgs, config, ...}: let
  aliases = {
    "db" = "distrobox";
    "fl" = " ~/.local/flutter/bin/flutter";
    "arch" = "distrobox-enter arch -- zsh";
    "fedora" = "distrobox-enter Fedora -- zsh";
    "eza" = "eza -l --sort type --no-permissions --no-user --no-time --header --icons --no-filesize --group-directories-first";
    "tree" = "eza --tree";
    "ls" = "exa";
    "ll" = "eza";
    "éé" = "eza";
    "és" = "eza";
    "l" = "eza";
    "nv" = "nvim";
    ":q" = "exit";
    "q" = "exit";
    "gs" = "git status";
    "gb" = "git branch";
    "gch" = "git checkout";
    "gc" = "git commit";
    "ga" = "git add";
    "gr" = "git reset --soft HEAD~1";
    "vault" = "ga . && gc -m \"sync $(date '+%Y-%m-%d %H:%M')\" && git push";
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
            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word
            path+=('/home/diegopyl/.local/bin')
            
            export LD_LIBRARY_PATH=${config.home.homeDirectory}/.config/awesome:${pkgs.lua54Packages.lua}/lib/:${pkgs.pam}/lib:${pkgs.stdenv.cc.cc.lib}/lib
                  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

            export AUTO_NOTIFY_THRESHOLD=600

            # pnpm
         	export PNPM_HOME="/home/diegopyl/.local/share/pnpm"
         	case ":$PATH:" in
             	*":$PNPM_HOME:"*) ;;
             	*) export PATH="$PNPM_HOME:$PATH" ;;
         	esac
        	# pnpm end

            rxfetch
      '';
      shellAliases = aliases;
      plugins = [
        {
          name = "auto-notify";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-auto-notify";
            rev = "22b2c61ed18514b4002acc626d7f19aa7cb2e34c";
            sha256 = "sha256-x+6UPghRB64nxuhJcBaPQ1kPhsDx3HJv0TLJT5rjZpA=";
          };
        }
      ];
    };

    bash = {
      enable = true;
      shellAliases = aliases;
    };

    # nushell = {
    #   enable = true;
    #   shellAliases = aliases;
    #   extraConfig = ''
    #     $env.config = {
    #       show_banner: false,
    #     }
    #   '';
    # };
  };
}
