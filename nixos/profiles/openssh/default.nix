{
  services.openssh = {
    enable = true;

    permitRootLogin = "no";

    passwordAuthentication = false;

    hostKeys = [{
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }];

    knownHosts = {
      "x13".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFzrWwVWBZPpVP809744I0hpUncoDJ9goUBTt6JcY2AD root@x13";
    };
  };
}
