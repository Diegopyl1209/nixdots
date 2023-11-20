{ config, pkgs, inputs, outputs, colors, ... }:

let
  

in
{
  home.username = "diegopyl";
  home.homeDirectory = "/home/diegopyl";
  
  imports =
    [
      ./conf
      ./misc
      ../shared/bin/default.nix
      ../shared/lock.nix
      ./programs.nix
    ];
  
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      #outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  
  home = {
    activation = {
      installConfig = ''
        if [ ! -d "${config.home.homeDirectory}/.config/eww" ]; then
          ${pkgs.stow}/bin/stow -d ./.dotfiles/stow -t ~/ eww
        fi
        if [ ! -d "${config.home.homeDirectory}/.wallpapers" ]; then
          ${pkgs.stow}/bin/stow -d ./.dotfiles/stow -t ~/ wallpapers
        fi
      '';
    };
  };
  

  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/diegopyl/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
