{ pkgs, ... }:

{
  home.packages = with pkgs; [ bemenu ];

  pinentry.bemenu.enable = true;

  xdg.configFile."bemenu/config-dark".text = ''
    --fn "monospace 9"
    --ignorecase
    --no-overlap
    --list 15
    --tb #1d2021
    --tf #ebdbb2
    --fb #1d2021
    --ff #ebdbb2
    --nb #1d2021
    --nf #ebdbb2
    --hb #1d2021
    --hf #d65d0e
    --sb #1d2021
    --sf #ebdbb2
    --scb #1d2021
    --scf #ebdbb2
  '';

  xdg.configFile."bemenu/config-light".text = ''
    --fn "monospace 9"
    --ignorecase
    --no-overlap
    --list 15
    --tb #f9f5d7
    --tf #3c3836
    --fb #f9f5d7
    --ff #3c3836
    --nb #f9f5d7
    --nf #3c3836
    --hb #f9f5d7
    --hf #d65d0e
    --sb #f9f5d7
    --sf #3c3836
    --scb #f9f5d7
    --scf #3c3836
  '';

  themes.scripts.bemenu = ''
    case "$THEME" in
      dark) ln -sf ~/.config/bemenu/config-dark ~/.config/bemenu/config ;;
      light) ln -sf ~/.config/bemenu/config-light ~/.config/bemenu/config ;;
    esac
  '';
}
