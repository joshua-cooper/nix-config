{
  boot = {
    initrd.verbose = false;
    consoleLogLevel = 0;
    loader.timeout = 0;
    kernelParams = [ "quiet" "udev.log_level=3" ];
  };
}
