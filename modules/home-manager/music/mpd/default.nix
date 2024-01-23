{
  config,
  pkgs,
  ...
}: {
  services.mpd = {
    enable = false;
    musicDirectory = "${config.home.homeDirectory}/Música";
    dataDir = "${config.home.homeDirectory}/.config/mpd";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
    network.startWhenNeeded = true;
  };
  imports = [(import ./misc.nix {inherit pkgs;})];
}
