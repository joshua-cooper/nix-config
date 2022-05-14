{
  services.kanshi = {
    enable = true;

    profiles = {
      laptop.outputs = [{
        criteria = "eDP-1";
      }];

      docked.outputs = [
        {
          criteria = "Goldstar Company Ltd LG HDR 4K 0x000071E6";
          scale = 2.0;
          position = "0,0";
        }
        {
          criteria = "eDP-1";
          position = "1920,540";
        }
      ];
    };
  };
}
