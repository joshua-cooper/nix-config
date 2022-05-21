{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      settings = {
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.uidensity" = 1;
      };
    };
  };
}
