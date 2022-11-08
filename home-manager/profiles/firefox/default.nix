{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      darkreader
      tridactyl
    ];

    profiles.default = {
      id = 0;

      search = {
        default = "DuckDuckGo";
        force = true;
      };

      settings = {
        "browser.aboutwelcome.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.uidensity" = 1;
      };
    };
  };
}
