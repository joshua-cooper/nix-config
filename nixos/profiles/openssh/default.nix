{
  services.openssh = {
    enable = true;
    ports = [ 10 ];
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
}
