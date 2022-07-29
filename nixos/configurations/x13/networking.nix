{
  networking = {
    hostName = "x13";

    nameservers = [ "1.1.1.1#one.one.one.one" ];

    useNetworkd = true;

    interfaces = {
      enp0s31f6.useDHCP = true;
      wlan0.useDHCP = true;
    };
  };

  systemd.network.wait-online.anyInterface = true;
}
