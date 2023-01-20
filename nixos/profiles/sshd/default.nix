{ config, lib, ... }:

{
  services.openssh = {
    enable = true;

    permitRootLogin = "no";

    passwordAuthentication = false;

    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];
  };

  state.files =
    lib.concatMap (key: [ key.path (key.path + ".pub") ]) config.services.openssh.hostKeys;
}
