{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        tridactyl
      ];

      search = {
        default = "DuckDuckGo";
        force = true;
      };

      settings = {
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.uidensity" = 1;
        "browser.tabs.inTitlebar" = 0;
      };
    };
  };
}
