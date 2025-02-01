{
  username,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [age sops];
  sops = {
    defaultSopsFile = ../hosts/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      #sshKeyPaths = ["/home/${username}/.ssh/id_ed25519"];
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
      #generateKey = true;
    };
    secrets.hello = {};
  };
}
