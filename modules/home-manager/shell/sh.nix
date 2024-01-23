{
  pkgs,
  config,
  ...
}: let
  aliases = {
    "db" = "distrobox";
    "fl" = " ~/.local/flutter/bin/flutter";
    "neofetch" = "nitch";
    "fetch" = "nitch";
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
    
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set PATH ~/.local/share/flutter/bin $PATH # Add flutter to path
        
      '';
      plugins = [
        { name = "done"; src = pkgs.fishPlugins.done.src; }
        { name = "bass"; src = pkgs.fishPlugins.bass.src; }
        { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      ];
    };

    bash = {
      enable = true;
      shellAliases = aliases;
    };
    
  };
}
