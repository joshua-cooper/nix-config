{
  networking = {
    hostName = "x13";

    nameservers = [ "1.1.1.1#one.one.one.one" ];

    useDHCP = false;

    interfaces = {
      enp0s31f6.useDHCP = true;
      wlan0.useDHCP = true;
    };
  };
}
